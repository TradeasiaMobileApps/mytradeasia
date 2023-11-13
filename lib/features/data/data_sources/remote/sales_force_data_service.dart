import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_cp_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
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

  Future<Response<SalesforceCreateAccountModel>> createSFAccount(
      {required String? token,
      required String? name,
      required String? phone,
      required String? role,
      required String? company}) async {
    String toSFTypeId(String? role) {
      switch (role) {
        case "customer":
          return "012j0000000kpTYAAY";
        case "agent":
          return "012j0000000m8aQAAQ";
        default:
          return "012j0000000kpTYAAY";
      }
    }

    final response = await dio.post(
        "https://tradeasia--newmind.sandbox.my.salesforce.com/services/data/v58.0/sobjects/Account",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
        ),
        data: {
          "RecordTypeId": toSFTypeId(role), //customer
          "Name": name,
          "Phone": phone ?? "",
          "Business_Entity__c": company
        });

    final data = SalesforceCreateAccountModel.fromJson(response.data);
    log("SF ACCOUNT DATA : $data");

    return Response<SalesforceCreateAccountModel>(
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
        data: data);
  }
}
