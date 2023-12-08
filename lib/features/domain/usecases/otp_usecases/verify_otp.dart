import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/otp_entities/verify_otp_entity.dart';
import 'package:mytradeasia/features/domain/repository/otp_repository.dart';

class VerifyOTP
    implements UseCaseTwoParams<DataState<VerifyOTPEntity>, String, String> {
  final OTPRepository _otpRepository;

  VerifyOTP(this._otpRepository);

  @override
  Future<DataState<VerifyOTPEntity>> call(
      {required String paramsOne, required String paramsTwo}) {
    return _otpRepository.verifyOTP(paramsOne, paramsTwo);
  }
}
