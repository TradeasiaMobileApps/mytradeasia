
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_cp_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_opportunity_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_data_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_opportunity_model.dart';
import 'package:mytradeasia/helper/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Response<SalesforceCPModel>> getCostPrice(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenSF = prefs.getString("tokenSF") ?? "";

    final response = await dio.get(
      "https://tradeasia--newmind.sandbox.my.salesforce.com/services/data/v58.0/queryAll?q=${salesforceCPQuery(userId)}",
      options: Options(
        headers: {
          "Authorization": "Bearer $tokenSF",
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

    return Response<SalesforceCreateAccountModel>(
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
        data: data);
  }

  Future<Response<SalesforceCreateOpportunityModel>> createSFOpp(
      SalesforceCreateOpportunityForm formData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenSF = prefs.getString("tokenSF") ?? "";
    DateTime now = DateTime.now();
    // Format date
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final response = await dio.post(
        "https://tradeasia--newmind.sandbox.my.salesforce.com/services/data/v58.0/sobjects/Opportunity",
        options: Options(
          headers: {
            "Authorization": "Bearer $tokenSF",
            "Content-Type": "application/json"
          },
        ),
        data: {
          "Name": "Test Mods",
          "Business_Entity__c": formData.companyName,
          "AccountId": formData.userId,
          "Product_Name__c": "01tj0000002wbhDAAQ",
          "StageName": "Quotation",
          "ForecastCategoryName": "Best Case",
          "CloseDate": formattedDate,
          "Worked_by__c": "Test",
          "Origin__c": "Test",
          "Quantity__c": formData.quantity,
          "Description_of_Goods__c": "Test",
          "H_S_Code__c": formData.hsCode,
          "Packaging_Details__c": "Test",
          "Total_of_Containers__c": 10.0,
          "Container_Size__c": "20' FCL",
          "Port_of_Discharge__c": "a028G00000147yLQAQ"
        });

    final data = SalesforceCreateOpportunityModel.fromJson(response.data);

    return Response<SalesforceCreateOpportunityModel>(
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
        data: data);
  }

  Future<Response<SalesforceOpportunityModel>> getSFOpp(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenSF = prefs.getString("tokenSF") ?? "";
    id = await getSalesforceId();
    final response = await dio.get(
      "https://tradeasia--newmind.sandbox.my.salesforce.com/services/data/v58.0/queryAll?q=${salesforceOpportunityQuery(id)}",
      options: Options(
        headers: {
          "Authorization": "Bearer $tokenSF",
          "Content-Type": "application/json"
        },
      ),
    );
    final data = SalesforceOpportunityModel.fromJson(response.data);
    return Response<SalesforceOpportunityModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: data,
    );
  }
}
