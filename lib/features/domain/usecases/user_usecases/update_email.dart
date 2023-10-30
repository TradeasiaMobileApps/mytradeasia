import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class UpdateEmail implements UseCase<String, String> {
  UserRepository _userRepository;

  UpdateEmail(this._userRepository);

  @override
  Future<String> call({required String param}) async {
    return _userRepository.updateEmail(param);
  }
}
