import 'package:equatable/equatable.dart';

class RequestEntity extends Equatable {
  final int? productId;
  final int? uomId;
  final int? qty;
  final String? incoterm;
  final String? pod;
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? country;
  final String? dialingCode;
  final String? mobileNumber;
  final String? email;

  const RequestEntity({
    this.productId,
    this.uomId,
    this.qty,
    this.incoterm,
    this.pod,
    this.firstName,
    this.lastName,
    this.companyName,
    this.country,
    this.dialingCode,
    this.mobileNumber,
    this.email,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
