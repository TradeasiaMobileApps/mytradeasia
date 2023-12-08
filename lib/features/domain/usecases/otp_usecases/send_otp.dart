import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/otp_entities/send_otp_entity.dart';
import 'package:mytradeasia/features/domain/repository/otp_repository.dart';

class SendOTP implements UseCase<DataState<SendOTPEntity>, String> {
  final OTPRepository _otpRepository;

  SendOTP(this._otpRepository);

  @override
  Future<DataState<SendOTPEntity>> call({required String param}) {
    return _otpRepository.sendOTP(param);
  }
}
