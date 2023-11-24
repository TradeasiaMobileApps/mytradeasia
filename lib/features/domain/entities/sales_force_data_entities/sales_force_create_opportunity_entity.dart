import 'package:equatable/equatable.dart';

class SalesforceCreateOpportunityEntity extends Equatable {
  final String? id;
  final bool? success;
  final List<dynamic>? errors;

  const SalesforceCreateOpportunityEntity({this.id, this.success, this.errors});

  @override
  List<Object?> get props => [id, success, errors];
}

class SalesforceCreateOpportunityFormEntity extends Equatable {
  final String? userId;
  final String? companyName;
  final double? quantity;
  final String? hsCode;

  const SalesforceCreateOpportunityFormEntity(
      {required this.userId,
      required this.companyName,
      required this.quantity,
      required this.hsCode});

  @override
  List<Object?> get props => [userId, companyName, quantity, hsCode];
}
