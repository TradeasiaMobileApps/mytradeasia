import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class GetUserProfile implements UseCase<DataState<UserEntity>, void> {
  final UserRepository _userRepository;

  GetUserProfile(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({void param}) {
    return _userRepository.getUserProfile();
  }
}
