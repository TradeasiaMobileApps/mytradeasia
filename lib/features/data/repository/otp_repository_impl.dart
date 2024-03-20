import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/otp_service.dart';
import 'package:mytradeasia/features/domain/entities/otp_entities/send_otp_entity.dart';
import 'package:mytradeasia/features/domain/entities/otp_entities/verify_otp_entity.dart';
import 'package:mytradeasia/features/domain/repository/otp_repository.dart';

class OTPRepositoryImpl implements OTPRepository {
  final OtpService _otpService;

  OTPRepositoryImpl(this._otpService);

  @override
  Future<DataState<SendOTPEntity>> sendOTP(String email) async {
    try {
      final response = await _otpService.postSendOTP(email);
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
  Future<DataState<VerifyOTPEntity>> verifyOTP(
      String code, String email) async {
    try {
      final response = await _otpService.postVerifyOTP(code, email);

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
      log("ERROR : ${e.message}");
      return DataFailed(e);
    }
  }
}
