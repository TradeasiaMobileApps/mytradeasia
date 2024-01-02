import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_account_entity.dart';

class SalesforceCreateAccountModel extends SalesforceCreateAccountEntity {
  String? id;
  bool? success;
  List<dynamic>? errors;

  SalesforceCreateAccountModel({this.id, this.success, this.errors});

  SalesforceCreateAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    success = json['success'];
    if (json['errors'] != null) {
      errors = <dynamic>[];
      json['errors'].forEach((v) {
        errors!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['success'] = success;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v).toList();
    }
    return data;
  }
}

class SalesforceCreateAccountForm {
  String? name;
  String? phone;
  String? role;
  String? company;

  SalesforceCreateAccountForm({this.name, this.phone, this.role, this.company});
}
