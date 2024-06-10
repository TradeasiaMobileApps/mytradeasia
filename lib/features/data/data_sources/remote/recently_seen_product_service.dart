import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentlySeenProductService {
  final dio = Dio();

  Future<Response<List<AllProductModel>>> getRecentlySeen() async {
    const String endPoint = "recentlyViewedProducts";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await dio.get(newTradeasiaApi + endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final data = response.data["data"]["recently_viewed_product"] as List;

    final recentlySeenData =
        data.map((e) => AllProductModel.fromJson(e)).toList();
    return Response<List<AllProductModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: recentlySeenData,
    );
  }
}
