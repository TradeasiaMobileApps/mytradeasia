import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/user_models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final dio = Dio();

  Future<Response<UserModel>> getUserProfile() async {
    const String endPoint = "getUserProfile";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await dio.get(newTradeasiaApi + endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final data = response.data["data"];
    final userData = UserModel.fromJson(data["user"]);

    return Response<UserModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: userData,
    );
  }
}
