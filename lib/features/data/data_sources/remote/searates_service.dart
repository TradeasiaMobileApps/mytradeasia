import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_bl_model.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_route_model.dart';

class SearatesService {
  final dio = Dio();
  final String apiKey = "7CX5-1IW6-E2DL-3S8V-KNOF";

  Future<Response<SearatesRouteModel>> getRoute(
      {required String number,
      required String type,
      required String sealine}) async {
    final response = await dio.get(
        "https://tracking.searates.com/route?number=$number&type=$type&sealine=$sealine&api_key=$apiKey");
    log("ROUTE DATA : ${response.data}");
    final data = response.data;
    return Response<SearatesRouteModel>(
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        statusMessage: response.data['status'],
        data: SearatesRouteModel.fromJson(data));
  }

  Future<Response<SearatesBLModel>> trackByBL(String number) async {
    final response = await dio.get(
        "https://tracking.searates.com/reference?number=$number&api_key=$apiKey");
    final data = response.data;
    return Response<SearatesBLModel>(
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        statusMessage: response.data['status'],
        data: SearatesBLModel.fromJson(data));
  }
}
