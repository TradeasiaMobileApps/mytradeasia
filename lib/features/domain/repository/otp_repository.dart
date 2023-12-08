import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/otp_entities/send_otp_entity.dart';
import 'package:mytradeasia/features/domain/entities/otp_entities/verify_otp_entity.dart';

abstract class OTPRepository {
  Future<DataState<SendOTPEntity>> sendOTP(String email);
  Future<DataState<VerifyOTPEntity>> verifyOTP(String code, String email);
}
