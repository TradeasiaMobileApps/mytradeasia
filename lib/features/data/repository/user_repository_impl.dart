import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/firebase/auth_user_firebase.dart';
import 'package:mytradeasia/features/data/data_sources/remote/auth_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/recently_seen_product_service.dart';
import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';
import 'package:mytradeasia/features/data/model/user_models/user_model.dart';
import 'package:mytradeasia/features/data/model/user_sales_models/sales_login_response_model.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_credential_entity.dart';
import 'package:mytradeasia/features/domain/entities/user_entities/user_entity.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthUserFirebase _authUserFirebase;
  final RecentlySeenProductService _seenProductService;
  final AuthService _authService;

  UserRepositoryImpl(
      this._authUserFirebase, this._seenProductService, this._authService);

  @override
  Future<String> registerUser(UserEntity s) async {
    UserModel userData = UserModel(
      companyName: s.companyName,
      country: s.country,
      countryCode: s.countryCode,
      email: s.email,
      firstName: s.firstName,
      lastName: s.lastName,
      password: s.password,
      phone: s.phone,
      role: s.role,
    );
    final response = await _authUserFirebase.postRegisterUser(userData);
    return response;
  }

  @override
  Future<String> ssoRegisterUser(UserEntity s) async {
    UserModel userData = UserModel(
      companyName: s.companyName,
      country: s.country,
      countryCode: s.countryCode,
      email: s.email,
      firstName: s.firstName,
      lastName: s.lastName,
      role: s.role,
    );
    final response = await _authUserFirebase.ssoRegisterUser(userData);
    return response;
  }

  @override
  Future<dynamic> loginUser(Map<String, String> s) async {
    final response = await _authUserFirebase.postLoginUser(s);
    return response;
  }

  @override
  Stream<Map<String, dynamic>> getUserSnapshot() {
    final uid = _authUserFirebase.getCurrentUId();
    // var test = _authUserFirebase.getUserSnapshot(uid);

    return _authUserFirebase.getUserSnapshot(uid);
  }

  @override
  Future<String> getCurrentUserId() async {
    return _authUserFirebase.getCurrentUId();
  }

  @override
  void addRecentlySeen(Map<String, dynamic> s) {
    _authUserFirebase.addRecentlySeen(s);
  }

  @override
  Future<DataState<List<AllProductModel>>> getRecentlySeen() async {
    try {
      final response = await _seenProductService.getRecentlySeen();
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data!);
      } else {
        return DataFailed(DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getUserData() {
    return _authUserFirebase.getUserData();
  }

  @override
  void logoutUser() {
    _authUserFirebase.postLogoutUser();
  }

  @override
  Future<UserCredentialEntity> getUserCredentials() {
    return _authUserFirebase.getUserCredentials();
  }

  @override
  Future<String> updateProfile(Map<String, dynamic> data) {
    return _authUserFirebase.updateProfile(data);
  }

  @override
  Future<String> phoneAuthentication(String s) {
    return _authUserFirebase.phoneAuthentication(s);
  }

  @override
  Future<bool> verifyOtp(String s) {
    return _authUserFirebase.verifyOTP(s);
  }

  @override
  void sendResetPassword(String s) {
    return _authUserFirebase.sendResetPassword(s);
  }

  @override
  Future<dynamic> googleAuth() async {
    final response = await _authUserFirebase.googleAuth();
    if (response is Map) {
      return response["code"];
    }
    return response;
  }

  @override
  void deleteAccount() {
    _authUserFirebase.deleteAccount();
  }

  @override
  Future<String> updateEmail(String newEmail, String password) async {
    return await _authUserFirebase.updateEmail(newEmail, password);
  }

  @override
  void deleteRecentlySeen() {
    _authUserFirebase.deleteRecentlySeen();
  }

  @override
  Future<SalesLoginResponse> loginSales(Map<String, String> s) async {
    final response = await _authUserFirebase.postLoginSales(s);
    return response;
  }

  @override
  Future<DataState<UserEntity>> getUserProfile() async {
    try {
      final response = await _authService.getUserProfile();
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data!);
      } else {
        return DataFailed(DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
