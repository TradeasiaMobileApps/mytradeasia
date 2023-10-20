import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class SendResetPass implements UseCase<void, String> {
  final UserRepository _userRepository;

  SendResetPass(this._userRepository);

  @override
  Future<void> call({required String param}) async {
    _userRepository.sendResetPassword(param);
  }
}
