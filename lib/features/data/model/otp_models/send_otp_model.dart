import 'package:mytradeasia/features/domain/entities/otp_entities/send_otp_entity.dart';

class SendOTPModel extends SendOTPEntity {
  const SendOTPModel({required String status, String? message})
      : super(status, message);

  factory SendOTPModel.fromJson(Map<String, dynamic> json) =>
      SendOTPModel(status: json['status'], message: json['message']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
