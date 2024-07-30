import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/cart_models/add_cart_model.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
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

  Future<Response<List<CartModel>>> getCartItems() async {
    const String endPoint = "myCart";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await dio.get(newTradeasiaApi + endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final data = response.data["data"]["result"] as List;
    final myCart = data.map(((e) => CartModel.fromJson(e))).toList();

    return Response<List<CartModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: myCart,
    );
  }

  Future<String> deleteCartItems(int id) async {
    try {
      final String endPoint = "removeItem/$id/";

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      final response = await dio.get(
        newTradeasiaApi + endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      final data = response.data;

      if (data["status"] == true) {
        return "success";
      } else {
        return "failed";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<String> updateCartItems(CartModel cart) async {
    try {
      const String endPoint = "editCart";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      final body = cart.toJson();
      final response = await dio.put(
        newTradeasiaApi + endPoint,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: body,
      );
      final data = response.data;

      if (data["status"] == true) {
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
