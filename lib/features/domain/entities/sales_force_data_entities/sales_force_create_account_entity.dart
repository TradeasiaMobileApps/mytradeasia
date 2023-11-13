import 'package:equatable/equatable.dart';

class SalesforceCreateAccountEntity extends Equatable {
  String? id;
  bool? success;
  List<dynamic>? errors;

  SalesforceCreateAccountEntity({this.id, this.success, this.errors});

  @override
  List<Object?> get props => [id, success, errors];
}
