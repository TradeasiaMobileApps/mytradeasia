import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
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

  void getRfqList() async {
    const String url =
        "http://mytradeasia-backend.vercel.app/mytradeasia/rfq/createRfq";

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
              contentType: Headers.formUrlEncodedContentType,
              // extra: {'user_id': '1'},

              followRedirects: false,
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
              },
            ),
          )
          .then((value) => print(value));
      // print(response);
    } on DioException catch (e) {
      print(e);
    }
  }
}
