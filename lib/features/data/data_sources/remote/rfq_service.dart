import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/data_sources/firebase/auth_user_firebase.dart';
import 'package:mytradeasia/features/data/model/rfq_models/rfq_list_model.dart';
import 'package:mytradeasia/features/data/model/rfq_models/rfq_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RfqService {
  final dio = Dio();

  Future<Response<dynamic>>? submitRfqService(RfqModel rfqModel) async {
    final rfqData = json.encode(rfqModel.toJson());

    const String url = "http://10.0.2.2:3000/mytradeasia/rfq/createRfq";
    final response = await dio.post(
      url,
      data: rfqData,
    );

    return Response<dynamic>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: response.statusMessage,
    );
  }

  // Future<Response<List<RfqModel>>> getRfqList() async {
  //   var auth = AuthUserFirebase();

  //   String id = auth.getCurrentUId();

  //   String url = "http://10.0.2.2:3000/mytradeasia/rfq/getRfqList/$id";

  //   final response = await dio.get(
  //     url,
  //   );
  //   var rawData = response.data["payload"]["datas"] as List;
  //   var data = rawData.map((e) => RfqModel.fromJson(e)).toList();
  //   return Response<List<RfqModel>>(
  //     statusCode: response.statusCode,
  //     requestOptions: response.requestOptions,
  //     data: data,
  //   );
  // }

  Future<List<dynamic>> getRfq(String rfqType) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      var res = await dio.get("${newTradeasiaApi}myRFQs/$rfqType",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      var data;

      if (res.data["status"] == true) {
        data = res.data["data"]["rfq_detail"] as List<Map<String, dynamic>>;
      } else {
        data = [];
      }

      return data;
    } on DioException catch (e) {
      log(e.response!.data);
      return Future.error(e);
    }
  }

  Future<Response<RfqListModel>> getRfqList() async {
    try {
      var resultData = Future.wait([
        getRfq("submitted"),
        getRfq("quoted"),
        getRfq("approved"),
        getRfq("rejected"),
      ]);
      var rawData = await resultData;

      var data = RfqListModel.fromJson(rawData);

      return Response<RfqListModel>(
        statusCode: HttpStatus.ok,
        requestOptions: RequestOptions(),
        statusMessage: "Fetch Success",
        data: data,
      );
    } catch (e) {
      return Response<RfqListModel>(
        statusCode: 418,
        requestOptions: RequestOptions(),
        statusMessage: "error on fetch",
        data: null,
      );
    }
  }

  void createRfqList() async {
    const String url =
        "https://mytradeasia-backend.vercel.app/mytradeasia/rfq/createRfq";

    var data = jsonEncode(
      {
        "customer_id": 3,
        "sales_id": null,
        "firstname": "deri",
        "lastname": "deri",
        "phone": "91919191919",
        "country": "indonesia",
        "company": "chemtrade",
        "product_name": "Helium",
        "quantity": 3,
        "unit": "G",
        "incoterm": "FOB",
        "port_of_destination": "Surabaya",
        "message": "i want"
      },
    );

    try {
      final response = await dio
          .post(
            url,
            data: data,

            // queryParameters: {'user_id': '1'},
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: Headers.jsonContentType,
              },
              followRedirects: true, // allow redirects
            ),
          )
          .then((value) => print(value));
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<Response> approveQuote(int id) async {
    const String url = "http://10.0.2.2:3000/mytradeasia/rfq/approveQuote";

    try {
      final response = await dio.put(
        url,
        data: {"rfq_id": id},

        // queryParameters: {'user_id': '1'},
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          },
          followRedirects: true, // allow redirects
        ),
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(),
          statusCode: 400,
          statusMessage: 'error on approve quote');
    }
  }

  Future<Response> rejectQuote(int id) async {
    const String url = "http://10.0.2.2:3000/mytradeasia/rfq/rejectQuote";

    try {
      final response = await dio.put(
        url,
        data: {"rfq_id": id},

        // queryParameters: {'user_id': '1'},
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          },
          followRedirects: true, // allow redirects
        ),
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(),
          statusCode: 400,
          statusMessage: 'error on reject quote');
    }
  }
}
