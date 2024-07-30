import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';
import 'package:mytradeasia/features/domain/repository/cart_repository.dart';

class GetCart implements UseCase<DataState<List<CartEntity>>, void> {
  final CartRepository _cartRepository;

  GetCart(this._cartRepository);

  @override
  Future<DataState<List<CartEntity>>> call({void param}) {
    return _cartRepository.getCartItems();
  }
}
