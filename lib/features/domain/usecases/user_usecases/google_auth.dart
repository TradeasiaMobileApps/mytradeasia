import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class GoogleAuth implements UseCase<dynamic, void> {
  final UserRepository _userRepository;

  GoogleAuth(this._userRepository);

  @override
  Future<dynamic> call({void param}) {
    return _userRepository.googleAuth();
  }
}
