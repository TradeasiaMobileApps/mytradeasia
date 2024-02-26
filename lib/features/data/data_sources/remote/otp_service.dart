import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/otp_models/send_otp_model.dart';
import 'package:mytradeasia/features/data/model/otp_models/verify_otp_model.dart';

class OtpService {
  final dio = Dio();

  Future<Response<SendOTPModel>> postSendOTP(String email) async {
    String url = "${mytradeasiaBackend}/sendOtp";

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {"email": email};

    final response =
        await dio.post(url, data: body, options: Options(headers: headers));
    return Response<SendOTPModel>(
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        data: SendOTPModel.fromJson(response.data));
  }

  Future<Response<VerifyOTPModel>> postVerifyOTP(
      String code, String email) async {
    String url = "${mytradeasiaBackend}/checkOTP";

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {"code": code, "email": email};

    final response =
        await dio.post(url, data: body, options: Options(headers: headers));
    return Response<VerifyOTPModel>(
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        data: VerifyOTPModel.fromJson(response.data));
  }
}
