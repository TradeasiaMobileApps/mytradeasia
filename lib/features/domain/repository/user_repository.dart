import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';

abstract class UserRepository {
  Future<String> registerUser(UserEntity s);
  Future<String> ssoRegisterUser(UserEntity s);
  Future<dynamic> loginUser(Map<String, String> s);
  Future<dynamic> googleAuth();
  void logoutUser();
  Stream<Map<String, dynamic>> getUserSnapshot();
  Future<Map<String, dynamic>> getUserData();
  Future<String> getCurrentUserId();
  void addRecentlySeen(Map<String, dynamic> s);
  Future<List<dynamic>> getRecentlySeen();
  Future<UserCredentialEntity> getUserCredentials();
  Future<String> updateProfile(Map<String, dynamic> data);
  Future<String> phoneAuthentication(String s);
  Future<bool> verifyOtp(String s);
  void sendResetPassword(String s);
}
