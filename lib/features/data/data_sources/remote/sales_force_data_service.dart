import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_cp_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_data_model.dart';

class SalesforceDataService {
  final dio = Dio();

  Future<Response<SalesforceDataModel>> getAllData(String token) async {
    final response = await dio.get(
      salesforceDataApi,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      ),
    );

    final data = response.data;

    final dataMapped = SalesforceDataModel.fromJson(data);

    return Response<SalesforceDataModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: dataMapped,
    );
  }

  Future<Response<SalesforceCPModel>> getCostPrice(String token) async {
    final response = await dio.get(
      "https://tradeasia--newmind.sandbox.my.salesforce.com/services/data/v58.0/queryAll?q=$salesforceCPQuery",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      ),
    );
    final data = SalesforceCPModel.fromJson(response.data);
    return Response<SalesforceCPModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: data,
    );
  }
}
