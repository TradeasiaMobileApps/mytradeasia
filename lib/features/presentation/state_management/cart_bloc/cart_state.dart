import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';

class CartState extends Equatable {
  final List<CartEntity>? cartItems;
  final DioException? error;

  const CartState({this.cartItems, this.error});

  @override
  List<Object?> get props => [cartItems, error];
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartDoneState extends CartState {
  const CartDoneState({
    List<CartEntity>? cartItems,
    String? addCartStatus,
    String? deleteItemStatus,
    String? updateItemStatus,
  }) : super(cartItems: cartItems);
}

class CartErrorState extends CartState {
  const CartErrorState(DioException error) : super(error: error);
}
