import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';
import 'package:mytradeasia/features/domain/repository/cart_repository.dart';

class AddCart implements UseCase<String, AddCartEntities> {
  final CartRepository _cartRepository;

  AddCart(this._cartRepository);

  @override
  Future<String> call({required AddCartEntities param}) {
    return _cartRepository.addCartItem(param);
  }
}
