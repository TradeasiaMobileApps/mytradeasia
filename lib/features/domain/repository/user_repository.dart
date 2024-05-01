import 'package:mytradeasia/features/data/model/user_sales_models/sales_login_response_model.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/all_product_entity.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';

abstract class UserRepository {
  Future<String> registerUser(UserEntity s);
  Future<String> ssoRegisterUser(UserEntity s);
  Future<dynamic> loginUser(Map<String, String> s);
  Future<SalesLoginResponse> loginSales(Map<String, String> s);
  Future<dynamic> googleAuth();
  void logoutUser();
  Stream<Map<String, dynamic>> getUserSnapshot();
  Future<Map<String, dynamic>> getUserData();
  Future<String> getCurrentUserId();
  void addRecentlySeen(Map<String, dynamic> s);
  Future<List<AllProductEntities>> getRecentlySeen();
  void deleteRecentlySeen();
  Future<UserCredentialEntity> getUserCredentials();
  Future<String> updateProfile(Map<String, dynamic> data);
  Future<String> phoneAuthentication(String s);
  Future<bool> verifyOtp(String s);
  Future<String> updateEmail(String newEmail, String password);
  void sendResetPassword(String s);
  void deleteAccount();
}
