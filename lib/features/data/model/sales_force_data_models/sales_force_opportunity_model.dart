import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_opportunity_entity.dart';

class SalesforceOpportunityModel extends SalesforceOpportunityEntity {
  int? totalSize;
  bool? done;
  List<Opportunity>? records;

  SalesforceOpportunityModel({this.totalSize, this.done, this.records});

  SalesforceOpportunityModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['totalSize'];
    done = json['done'];
    if (json['records'] != null) {
      records = <Opportunity>[];
      json['records'].forEach((v) {
        records!.add(new Opportunity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSize'] = this.totalSize;
    data['done'] = this.done;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
