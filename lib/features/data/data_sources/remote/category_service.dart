import 'package:dio/dio.dart';
import 'package:mytradeasia/features/data/model/category_models/category_model.dart';

class CategoryService {
  final dio = Dio();

  Future<Response<List<CategoryIndustryModel>>> getCategories() async {
    const String endPoint = "https://tradeasia.vn/api/productByCategory";
    final response = await dio.get(endPoint);
    final data = response.data["data"]["product_industry_category"] as List;
    final allIndustry =
        data.map(((e) => CategoryIndustryModel.fromJson(e))).toList();

    return Response<List<CategoryIndustryModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: allIndustry,
    );
  }
}
