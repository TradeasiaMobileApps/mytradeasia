import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_account_entity.dart';

class SalesforceCreateAccountModel extends SalesforceCreateAccountEntity {
  const SalesforceCreateAccountModel(
      {required String sfAccountId,
      required String sfContactId,
      bool? success,
      List<dynamic>? errors})
      : super(
            sfAccountId: sfAccountId,
            sfContactId: sfContactId,
            success: success,
            errors: errors);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = id;
  //   data['success'] = success;
  //   if (errors != null) {
  //     data['errors'] = errors!.map((v) => v).toList();
  //   }
  //   return data;
  // }
}

class SalesforceCreateAccountForm {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  String? company;
  String? country;

  SalesforceCreateAccountForm(
      {this.firstName,
      this.lastName,
      this.email,
      this.country,
      this.phone,
      this.role,
      this.company});
}
