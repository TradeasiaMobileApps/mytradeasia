import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

import '../../entities/all_product_entities/all_product_entity.dart';

class GetRecentlySeen
    implements UseCase<DataState<List<AllProductEntities>>, void> {
  final UserRepository _userRepository;

  GetRecentlySeen(this._userRepository);

  @override
  Future<DataState<List<AllProductEntities>>> call({void param}) {
    return _userRepository.getRecentlySeen();
  }
}
