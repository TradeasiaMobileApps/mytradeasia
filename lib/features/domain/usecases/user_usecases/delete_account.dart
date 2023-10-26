import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class DeleteAccount implements UseCase<void, void> {
  final UserRepository _userRepository;
  DeleteAccount(this._userRepository);

  @override
  Future<void> call({void param}) async {
    // TODO: implement call
    _userRepository.deleteAccount();
  }
}
