import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

import '../../entities/all_product_entities/all_product_entity.dart';

class GetRecentlySeen implements UseCase<List<AllProductEntities>, void> {
  final UserRepository _userRepository;

  GetRecentlySeen(this._userRepository);

  @override
  Future<List<AllProductEntities>> call({void param}) {
    return _userRepository.getRecentlySeen();
  }
}
