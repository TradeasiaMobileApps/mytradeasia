import 'package:equatable/equatable.dart';

class VerifyOTPEntity extends Equatable {
  final String status;
  final String? message;

  const VerifyOTPEntity(this.status, this.message);

  @override
  List<Object?> get props => [status, message];
}
