import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/user_models/user_model.dart';
import 'package:mytradeasia/utils/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class AuthService {
  final dio = Dio();
  NotificationService notificationServices = NotificationService();

  Future<Response<UserModel>> getUserProfile() async {
    const String endPoint = "getUserProfile";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      final response = await dio.get(newTradeasiaApi + endPoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      final data = response.data["data"];
      final userData = UserModel.fromJson(data["user"]);

      return Response<UserModel>(
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
        data: userData,
      );
    } catch (e) {
      log(e.toString());
      return Response<UserModel>(
        statusCode: HttpStatus.badRequest,
        requestOptions: RequestOptions(),
        data: null,
      );
    }
  }

  Future<Response<bool>> checkIfUserExist(
      String ssoId, String loginType, String email) async {
    final currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (loginType != "by_form") {
      notificationServices.requestNotificationPermission();
      String? deviceToken = await notificationServices.getDeviceToken();

      await prefs.setString("device_token", deviceToken);

      const String endPoint = "checkSocialLogin";
      final body = {
        "social_id": ssoId,
        "login_type": loginType,
        "timezone": currentTimeZone,
        "device_token": deviceToken
      };
      final response = await dio.post(newTradeasiaApi + endPoint, data: body);
      bool isFound = response.data['status'];

      return Response<bool>(
          statusCode: response.statusCode,
          requestOptions: response.requestOptions,
          data: isFound);
    } else {
      //using verifyFPOTP to check if user email exist or not if not using a sso
      const String endPoint = "verifyFPOTP";

      final body = {"email": email, "otp": 4444};
      try {
        final response = await dio.post(newTradeasiaApi + endPoint, data: body);

        if (response.data["message"] == "You have entered incorrect otp.") {
          return Response<bool>(
              statusCode: response.statusCode,
              requestOptions: response.requestOptions,
              data: false);
        } else {
          return Response<bool>(
              statusCode: response.statusCode,
              requestOptions: response.requestOptions,
              data: true);
        }
      } catch (e) {
        log(e.toString());
        return Response<bool>(
            statusCode: 400, requestOptions: RequestOptions(), data: false);
      }
    }
  }
}
