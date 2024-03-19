import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/home_models/home_model.dart';

class HomeService {
  final dio = Dio();

  Future<Response<HomeModel>> getHomeData() async {
    const String endPoint = "home";
    final response = await dio.post(newTradeasiaApi + endPoint);
    final data = response.data["data"];
    final homeData = HomeModel.fromJson(data);

    return Response<HomeModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: homeData,
    );
  }
}
