import 'dart:developer';
import 'dart:io';

import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/firebase/cart_firebase.dart';
import 'package:mytradeasia/features/data/data_sources/remote/cart_service.dart';
import 'package:mytradeasia/features/data/model/cart_models/add_cart_model.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';
import 'package:mytradeasia/features/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartFirebase _cartFirebase;
  final CartService _cartService;

  CartRepositoryImpl(this._cartFirebase, this._cartService);

  @override
  Future<List<CartModel>> getCartItems() async {
    try {
      return await _cartFirebase.getCartItems();
    } catch (e) {
      return Future.error(e.toString());
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
  Future<String> deleteCartItems(List<CartModel> cart) async {
    try {
      return await _cartFirebase.deleteCartItems(cart);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<String> updateCartItem(
      {required List<CartModel> cart,
      required CartModel product,
      required double quantity,
      required String unit}) async {
    try {
      return await _cartFirebase.updateCartItem(
          cart: cart, product: product, quantity: quantity, unit: unit);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
