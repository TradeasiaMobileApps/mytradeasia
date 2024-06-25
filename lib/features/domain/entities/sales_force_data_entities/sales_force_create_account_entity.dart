import 'package:equatable/equatable.dart';

class SalesforceCreateAccountEntity extends Equatable {
  final String? sfAccountId;
  final String? sfContactId;
  final bool? success;
  final List<dynamic>? errors;

  const SalesforceCreateAccountEntity(
      {this.sfAccountId, this.sfContactId, this.success, this.errors});

  @override
  List<Object?> get props => [sfAccountId, sfContactId, success, errors];
}
