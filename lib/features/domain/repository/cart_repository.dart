import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';

abstract class CartRepository {
  Future<DataState<List<CartEntity>>> getCartItems();
  Future<String> addCartItem(AddCartEntities product);
  Future<String> deleteCartItems(int id);
  Future<String> updateCartItem(
    CartEntity product,
  );
}
