import 'package:equatable/equatable.dart';

class SalesforceCreateOpportunityEntity extends Equatable {
  String? id;
  bool? success;
  List<dynamic>? errors;

  SalesforceCreateOpportunityEntity({this.id, this.success, this.errors});

  @override
  List<Object?> get props => [id, success, errors];
}
