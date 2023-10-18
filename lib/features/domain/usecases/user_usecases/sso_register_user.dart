import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class SSORegisterUser implements UseCase<String, UserEntity> {
  final UserRepository _userRepository;

  SSORegisterUser(this._userRepository);

  @override
  Future<String> call({required UserEntity param}) {
    return _userRepository.ssoRegisterUser(param);
  }
}
