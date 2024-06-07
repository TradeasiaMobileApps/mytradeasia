import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/home_models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final dio = Dio();

  Future<Response<HomeModel>> getHomeData() async {
    const String endPoint = "home";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await dio.post(newTradeasiaApi + endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final data = response.data["data"];
    final homeData = HomeModel.fromJson(data);

    return Response<HomeModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: homeData,
    );
  }
}
