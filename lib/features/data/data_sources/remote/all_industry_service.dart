import 'package:mytradeasia/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:mytradeasia/features/data/model/all_industry_models/all_industry_model.dart';

class AllIndustryService {
  final dio = Dio();

  Future<Response<AllIndustryModel>> getAllIndustryList() async {
    const String endPoint = "https://tradeasia.vn/api/industryList";
    final response = await dio.get(endPoint);
    final data = response.data["data"];
    final allIndustry = AllIndustryModel.fromJson(data);

    return Response<AllIndustryModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: allIndustry,
    );
  }
}
