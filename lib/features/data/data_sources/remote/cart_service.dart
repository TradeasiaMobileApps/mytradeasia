import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/cart_models/add_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final dio = Dio();

  Future<String> addCartItem(AddCartModel product) async {
    try {
      const String endPoint = "addCart";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final body = product.toJson();
      String? token = prefs.getString("token");
      final response = await dio.post(newTradeasiaApi + endPoint,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: body);
      log(response.data.toString());
      if (response.data["status"] == true) {
        return "success";
      } else {
        return "failed";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
