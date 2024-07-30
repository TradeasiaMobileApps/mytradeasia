import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final AddCartEntities product;

  const AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  // final int cartId;

  const RemoveFromCart();
}

class UpdateCartItem extends CartEvent {
  final CartEntity product;

  const UpdateCartItem(
    this.product,
  );
}

class GetCartItems extends CartEvent {
  const GetCartItems();
}
