import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class UpdateEmail implements UseCaseTwoParams<String, String, String> {
  UserRepository _userRepository;

  UpdateEmail(this._userRepository);

  @override
  Future<String> call({required String paramsOne, required String paramsTwo}) {
    return _userRepository.updateEmail(paramsOne, paramsTwo);
  }
}
