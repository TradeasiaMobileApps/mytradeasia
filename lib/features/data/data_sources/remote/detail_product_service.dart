import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/detail_product_models/detail_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProductService {
  final dio = Dio();

  Future<Response<DetailsProductModel>> getDetailProduct(
      String productId) async {
    String endpoint = "productDetails/$productId";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var full_date = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    String device_type;

    if (Platform.isAndroid) {
      device_type = "android";
    } else {
      device_type = "ios";
    }

    final response = await dio.get(newTradeasiaApi + endpoint,
        options: Options(headers: {
          "datetime": full_date,
          "device_type": device_type,
          "role": "customer",
          "Authorization": "Bearer $token"
        }));

    final data = response.data;

    final detailProductModel = DetailsProductModel.fromJson(data['data']);
    // print(detailProductModel);
    return Response<DetailsProductModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: detailProductModel,
    );
  }
}
