import 'package:dio/dio.dart';
import 'package:mytradeasia/features/data/model/detail_product_models/detail_product_model.dart';

class DetailProductService {
  final dio = Dio();

  Future<Response<DetailsProductModel>> getDetailProduct(
      String productId) async {
    String url = "https://tradeasia.vn/api/productDetails/$productId";

    final response = await dio.get(url);

    final data = response.data;

    final detailProductModel = DetailsProductModel.fromJson(data['data']);
    print(detailProductModel);
    return Response<DetailsProductModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: detailProductModel,
    );
  }
}
