import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/search_product_models/search_product_model.dart';

class SearchProductService {
  List<SearchProductModel> resultAwal = [];
  final dio = Dio();

  Future<Response<List<SearchProductModel>>> getSearchProduct(
      String productName) async {
    String endpoint = "${newTradeasiaApi}homeProductSearch";
    final response = await dio.post(endpoint, data: {"search": productName});

    final dataList = response.data["data"]["product_search"] as List<dynamic>;
    final listProductModel =
        dataList.map((e) => SearchProductModel.fromJson(e)).toList();

    return Response<List<SearchProductModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: listProductModel,
    );
  }
}
