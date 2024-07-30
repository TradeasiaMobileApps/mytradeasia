import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/cart_service.dart';
import 'package:mytradeasia/features/data/model/cart_models/add_cart_model.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';
import 'package:mytradeasia/features/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartService _cartService;

  CartRepositoryImpl(this._cartService);

  @override
  Future<DataState<List<CartModel>>> getCartItems() async {
    try {
      final response = await _cartService.getCartItems();
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data!);
      } else {
        return DataFailed(DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<String> addCartItem(AddCartEntities product) async {
    AddCartModel productModel = AddCartModel(
        productId: product.productId,
        uomId: product.uomId,
        qty: product.qty,
        incoterm: product.incoterm,
        pod: product.pod,
        note: product.note);
    try {
      final response = await _cartService.addCartItem(productModel);
      return response;
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }

  @override
  Future<String> deleteCartItems(int id) async {
    try {
      final response = await _cartService.deleteCartItems(id);
      return response;
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }

  @override
  Future<String> updateCartItem(CartEntity product) async {
    CartModel addCartModel = CartModel(
      id: product.id,
      cartId: product.cartId,
      userId: product.userid,
      uomId: product.uomId,
      productId: product.productId,
      quantity: product.quantity,
      incoterm: product.incoterm,
      pod: product.pod,
      note: product.note,
    );

    try {
      final response = await _cartService.updateCartItems(addCartModel);
      return response;
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }
}
