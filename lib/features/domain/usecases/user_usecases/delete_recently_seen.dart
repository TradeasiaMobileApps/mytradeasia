import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class DeleteRecentlySeen implements UseCase<void, void> {
  final UserRepository _userRepository;

  DeleteRecentlySeen(this._userRepository);

  @override
  Future<void> call({void param}) async {
    _userRepository.deleteRecentlySeen();
  }
}
