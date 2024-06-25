import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class CheckUserExist
    implements UseCaseThreeParams<bool, String, String, String> {
  final UserRepository userRepository;

  CheckUserExist(this.userRepository);

  /// @paramsOne is for ssoId, @paramsTwo is for loginType, [paramsThree] is for email
  @override
  Future<bool> call({
    required String paramsOne,
    required String paramsTwo,
    required String paramsThree,
  }) async {
    final ssoId = paramsOne;
    final loginType = paramsTwo;
    final email = paramsThree;

    return userRepository.checkIfUserExist(ssoId, loginType, email);
  }
}
