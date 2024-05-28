import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/data/model/user_sales_models/sales_login_response_model.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class LoginSales implements UseCase<dynamic, Map<String, String>> {
  final UserRepository _userRepository;

  LoginSales(this._userRepository);

  @override
  Future<SalesLoginResponse> call({required Map<String, String> param}) {
    return _userRepository.loginSales(param);
  }
}
