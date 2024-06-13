import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/model/user_sales_models/sales_login_response_model.dart';
import 'package:mytradeasia/features/domain/entities/all_product_entities/all_product_entity.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/add_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/delete_account.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/delete_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_current_userid.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_credentials.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_data.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_profile.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_snapshot.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/google_auth.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/login.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/login_sales.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/logout.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/phone_authentication.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/register.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/send_reset_pass.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/sso_register_user.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_email.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_profile.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/verify_otp.dart';

class UserUsecaseIndex {
  final UserRepository userRepository;

  UserUsecaseIndex(this.userRepository);

  Future<dynamic> loginUser({required Map<String, String> loginCredential}) {
    return LoginUser(userRepository).call(param: loginCredential);
  }

  Future<String> registerUser({required UserEntity user}) {
    return RegisterUser(userRepository).call(param: user);
  }

  Future<String> ssoRegisterUser({required UserEntity user}) {
    return SSORegisterUser(userRepository).call(param: user);
  }

  Future<SalesLoginResponse> loginSales({required Map<String, String> sales}) {
    return LoginSales(userRepository).call(param: sales);
  }

  Future<dynamic> googleAuth() {
    return GoogleAuth(userRepository).call();
  }

  void logoutUser() {
    LogOutUser(userRepository).call();
  }

  Stream<Map<String, dynamic>> getUserSnapshot() {
    return GetUserSnapshot(userRepository).call();
  }

  Future<Map<String, dynamic>> getUserData() {
    return GetUserData(userRepository).call();
  }

  Future<String> getCurrentUserId() {
    return GetCurrentUserId(userRepository).call();
  }

  void addRecentlySeen(Map<String, dynamic> item) {
    AddRecentlySeen(userRepository).call(param: item);
  }

  Future<DataState<List<AllProductEntities>>> getRecentlySeen() {
    return GetRecentlySeen(userRepository).call();
  }

  void deleteRecentlySeen() {
    DeleteRecentlySeen(userRepository).call();
  }

  Future<UserCredentialEntity> getUserCredentials() {
    return GetUserCredentials(userRepository).call();
  }

  Future<String> updateProfile(Map<String, dynamic> userData) {
    return UpdateProfile(userRepository).call(param: userData);
  }

  Future<String> phoneAuthentication(String phone) {
    return PhoneAuthentication(userRepository).call(param: phone);
  }

  Future<bool> verifyOtp(String otp) {
    return VerifyOtp(userRepository).call(param: otp);
  }

  Future<String> updateEmail(String newEmail, String password) {
    return UpdateEmail(userRepository)
        .call(paramsOne: newEmail, paramsTwo: password);
  }

  void sendResetPassword(String email) {
    SendResetPass(userRepository).call(param: email);
  }

  void deleteAccount() {
    DeleteAccount(userRepository).call();
  }

  Future<DataState<UserEntity>> getUserProfile() {
    return GetUserProfile(userRepository).call();
  }
}
