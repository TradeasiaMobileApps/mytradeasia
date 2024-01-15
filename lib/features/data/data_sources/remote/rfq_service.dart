import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/data_sources/firebase/auth_user_firebase.dart';
import 'package:mytradeasia/features/data/model/rfq_models/rfq_model.dart';
import 'dart:convert';

class RfqService {
  final dio = Dio();

  Future<Response<dynamic>>? submitRfqService(RfqModel rfqModel) async {
    final rfqData = json.encode(rfqModel.toJson());

    print(rfqData);

    const String url = "$tradeasiaApi/storequote";
    final response = await dio.post(
      url,
      data: rfqData,
    );

    return Response<dynamic>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: response.statusMessage,
    );

    // return Response(requestOptions: RequestOptions());
  }

  Future<Response<List<RfqModel>>> getRfqList() async {
    var auth = AuthUserFirebase();

    String id = auth.getCurrentUId();

    String url =
        "http://mytradeasia-backend.vercel.app/mytradeasia/rfq/getRfqList/3";

    final response = await dio.get(
      url,
    );
    var rawData = response.data["payload"]["datas"] as List;
    var data = rawData.map((e) => RfqModel.fromJson(e)).toList();
    return Response<List<RfqModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: data,
    );
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
      // print(response);
    } on DioException catch (e) {
      print(e);
    }
  }
}
