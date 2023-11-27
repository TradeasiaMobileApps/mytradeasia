import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_opportunity_entity.dart';

class SalesforceCreateOpportunityModel
    extends SalesforceCreateOpportunityEntity {
  const SalesforceCreateOpportunityModel({
    String? id,
    bool? success,
    List<dynamic>? errors,
  }) : super(id: id, success: success, errors: errors);

  factory SalesforceCreateOpportunityModel.fromJson(Map<String, dynamic> json) {
    var errors;
    if (json['errors'] != null) {
      errors = <dynamic>[];
      json['errors'].forEach((v) {
        errors!.add((v));
      });
    }
    return SalesforceCreateOpportunityModel(
        id: json['id'], success: json['success'], errors: errors);
  }
  // id = json['id'];
  // success = json['success'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['success'] = this.success;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v).toList();
    }
    return data;
  }
}

class SalesforceCreateOpportunityForm
    extends SalesforceCreateOpportunityFormEntity {
  const SalesforceCreateOpportunityForm({
    String? userId,
    String? companyName,
    double? quantity,
    String? hsCode,
  }) : super(
          userId: userId,
          companyName: companyName,
          quantity: quantity,
          hsCode: hsCode,
        );
}
