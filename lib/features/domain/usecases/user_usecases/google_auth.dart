import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class GoogleAuth implements UseCase<UserCredentialEntity, void> {
  final UserRepository _userRepository;

  GoogleAuth(this._userRepository);

  @override
  Future<UserCredentialEntity> call({void param}) {
    return _userRepository.googleAuth();
  }
}
