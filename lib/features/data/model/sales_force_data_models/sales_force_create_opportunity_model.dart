import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_opportunity_entity.dart';

class SalesforceCreateOpportunityModel
    extends SalesforceCreateOpportunityEntity {
  String? id;
  bool? success;
  List<dynamic>? errors;

  SalesforceCreateOpportunityModel({this.id, this.success, this.errors});

  SalesforceCreateOpportunityModel.fromJson(Map<String, dynamic> json) {
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
    data['id'] = this.id;
    data['success'] = this.success;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v).toList();
    }
    return data;
  }
}

class SalesforceCreateOpportunityForm {
  String userId;
  String companyName;
  double quantity;
  String hsCode;

  SalesforceCreateOpportunityForm(
      {required this.userId,
      required this.companyName,
      required this.quantity,
      required this.hsCode});
}
