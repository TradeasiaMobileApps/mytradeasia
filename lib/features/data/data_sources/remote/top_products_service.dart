import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/top_products_models/top_product_model.dart';

class TopProductsService {
  List<TopProductsModel> resultAwal = [];
  final dio = Dio();

  Future<Response<List<TopProductsModel>>> getTopProducts() async {
    const String endPoint = "topProducts";
    final response = await dio.get(newTradeasiaApi + endPoint);

    final dataList = response.data["data"]["top_product"]["data"] as List;
    final listProductModel =
        dataList.map((e) => TopProductsModel.fromJson(e)).toList();

    return Response<List<TopProductsModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: listProductModel,
    );
  }
}
