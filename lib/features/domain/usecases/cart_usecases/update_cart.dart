import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';
import 'package:mytradeasia/features/domain/repository/cart_repository.dart';

class UpdateCart implements UseCase<String, CartEntity> {
  final CartRepository _cartRepository;

  UpdateCart(this._cartRepository);

  @override
  Future<String> call({required CartEntity param}) async {
    return _cartRepository.updateCartItem(param);
  }
}
