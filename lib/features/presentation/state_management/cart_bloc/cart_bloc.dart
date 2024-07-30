import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/add_cart.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/delete_cart_item.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/get_cart.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/update_cart.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_event.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart _getCart;
  final AddCart _addCart;
  final DeleteCartItem _deleteCartItem;
  final UpdateCart _updateCart;

  CartBloc(this._getCart, this._addCart, this._deleteCartItem, this._updateCart)
      : super(const CartLoadingState()) {
    on<GetCartItems>(onGetCartItems);
    on<AddToCart>(onAddCartItem);
    on<RemoveFromCart>(onRemoveFromCart);
    on<UpdateCartItem>(onUpdateCartItem);
  }

  void onGetCartItems(GetCartItems event, Emitter<CartState> emit) async {
    final dataState = await _getCart();

    if (dataState is DataSuccess) {
      emit(CartDoneState(cartItems: dataState.data));
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(CartErrorState(dataState.error!));
    }
  }

  void onAddCartItem(AddToCart event, Emitter<CartState> emit) async {
    final data = await _addCart(param: event.product);

    if (data != "error") {
      emit(CartDoneState(addCartStatus: data, cartItems: state.cartItems));
    } else {
      emit(
        CartErrorState(
          DioException(
              requestOptions: RequestOptions(),
              message: "Error on adding to cart"),
        ),
      );
    }
  }

  void onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    for (var e in state.cartItems!) {
      if (e.isChecked!) {
        final data = await _deleteCartItem(param: e.id);
        if (data != "error") {
          emit(CartDoneState(
              deleteItemStatus: data, cartItems: state.cartItems));
        } else {
          emit(
            CartErrorState(
              DioException(
                  requestOptions: RequestOptions(),
                  message: "Error on Deleting to cart"),
            ),
          );
        }
      }
    }
  }

  void onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    final data = await _updateCart.call(param: event.product);
    if (data != "error") {
      emit(CartDoneState(updateItemStatus: data, cartItems: state.cartItems));
    } else {
      emit(
        CartErrorState(
          DioException(
              requestOptions: RequestOptions(),
              message: "Error on Updating to cart"),
        ),
      );
    }
  }
}
