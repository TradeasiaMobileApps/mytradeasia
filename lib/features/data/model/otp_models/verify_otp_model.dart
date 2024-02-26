import 'package:mytradeasia/features/domain/entities/otp_entities/verify_otp_entity.dart';

class VerifyOTPModel extends VerifyOTPEntity {
  const VerifyOTPModel({required String status, String? message})
      : super(status, message);

  factory VerifyOTPModel.fromJson(Map<String, dynamic> json) =>
      VerifyOTPModel(status: json['status'], message: json['message']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
