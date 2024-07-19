import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';

abstract class CartRepository {
  Future<List<CartModel>> getCartItems();
  Future<String> addCartItem(AddCartEntities product);
  Future<String> deleteCartItems(List<CartModel> cart);
  Future<String> updateCartItem(
      {required List<CartModel> cart,
      required CartModel product,
      required double quantity,
      required String unit});
}
