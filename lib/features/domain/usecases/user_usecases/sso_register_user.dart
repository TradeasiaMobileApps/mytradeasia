import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class SSORegisterUser implements UseCaseTwoParams<String, UserEntity, String> {
  final UserRepository _userRepository;

  SSORegisterUser(this._userRepository);

  ///the parameter @paramsOne is for UserEntity and @paramsTwo is for logintype
  @override
  Future<String> call(
      {required UserEntity paramsOne, required String paramsTwo}) {
    return _userRepository.ssoRegisterUser(paramsOne, paramsTwo);
  }
}
