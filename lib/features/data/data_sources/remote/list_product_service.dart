import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';

class ListProductService {
  final dio = Dio();

  Future<Response<List<AllProductModel>>> getListProduct() async {
    String endpoint = "productByIndustry";
    final response = await dio.post(newTradeasiaApi + endpoint);
    final dataList =
        response.data['data']['industry_product']['data'] as List<dynamic>;
    final listProductModel =
        dataList.map((e) => AllProductModel.fromJson(e)).toList();

    return Response<List<AllProductModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: listProductModel,
    );
  }
}
