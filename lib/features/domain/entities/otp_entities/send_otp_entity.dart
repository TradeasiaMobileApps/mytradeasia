import 'package:equatable/equatable.dart';

class SendOTPEntity extends Equatable {
  final String status;
  final String? message;

  const SendOTPEntity(this.status, this.message);

  @override
  List<Object?> get props => [status, message];
}
