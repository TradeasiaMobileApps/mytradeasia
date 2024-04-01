import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/all_product_models/lazy_load_list_product_model.dart';

class ListProductService {
  final dio = Dio();

  Future<Response<ProductLazyLoadModel>> getListProduct(
      String? nextPayload) async {
    String endpoint = "productByIndustry";
    final Response response;
    if (nextPayload == null) {
      response = await dio.post(newTradeasiaApi + endpoint);
    } else {
      response = await dio.post(nextPayload);
    }

    final dataList = response.data['data']['industry_product'];
    final listProductModel = ProductLazyLoadModel.fromJson(dataList);

    return Response<ProductLazyLoadModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: listProductModel,
    );
  }
}
