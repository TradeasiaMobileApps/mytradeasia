import 'package:equatable/equatable.dart';

class SalesforceOpportunityEntity extends Equatable {
  int? totalSize;
  bool? done;
  List<Opportunity>? records;

  SalesforceOpportunityEntity({this.totalSize, this.done, this.records});

  @override
  List<Object?> get props => [totalSize, done, records];
}

class Opportunity {
  OpportunityAttributes? attributes;
  String? id;
  String? name;
  String? accountId;
  Account? account;
  String? productNameC;
  Account? productNameR;
  String? uOMC;
  double? quantityC;
  Null? deliveryTermC;
  String? stageName;
  String? forecastCategoryName;
  String? closeDate;
  String? workedByC;
  String? originC;
  String? descriptionOfGoodsC;
  String? packagingDetailsC;
  String? hSCodeC;
  double? totalOfContainersC;
  String? containerSizeC;
  String? portOfDischargeC;
  String? businessEntityC;

  Opportunity(
      {this.attributes,
      this.id,
      this.name,
      this.accountId,
      this.account,
      this.productNameC,
      this.productNameR,
      this.uOMC,
      this.quantityC,
      this.deliveryTermC,
      this.stageName,
      this.forecastCategoryName,
      this.closeDate,
      this.workedByC,
      this.originC,
      this.descriptionOfGoodsC,
      this.packagingDetailsC,
      this.hSCodeC,
      this.totalOfContainersC,
      this.containerSizeC,
      this.portOfDischargeC,
      this.businessEntityC});

  Opportunity.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new OpportunityAttributes.fromJson(json['attributes'])
        : null;
    id = json['Id'];
    name = json['Name'];
    accountId = json['AccountId'];
    account =
        json['Account'] != null ? new Account.fromJson(json['Account']) : null;
    productNameC = json['Product_Name__c'];
    productNameR = json['Product_Name__r'] != null
        ? new Account.fromJson(json['Product_Name__r'])
        : null;
    uOMC = json['UOM__c'];
    quantityC = json['Quantity__c'];
    deliveryTermC = json['Delivery_Term__c'];
    stageName = json['StageName'];
    forecastCategoryName = json['ForecastCategoryName'];
    closeDate = json['CloseDate'];
    workedByC = json['Worked_by__c'];
    originC = json['Origin__c'];
    descriptionOfGoodsC = json['Description_of_Goods__c'];
    packagingDetailsC = json['Packaging_Details__c'];
    hSCodeC = json['H_S_Code__c'];
    totalOfContainersC = json['Total_of_Containers__c'];
    containerSizeC = json['Container_Size__c'];
    portOfDischargeC = json['Port_of_Discharge__c'];
    businessEntityC = json['Business_Entity__c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['AccountId'] = this.accountId;
    if (this.account != null) {
      data['Account'] = this.account!.toJson();
    }
    data['Product_Name__c'] = this.productNameC;
    if (this.productNameR != null) {
      data['Product_Name__r'] = this.productNameR!.toJson();
    }
    data['UOM__c'] = this.uOMC;
    data['Quantity__c'] = this.quantityC;
    data['Delivery_Term__c'] = this.deliveryTermC;
    data['StageName'] = this.stageName;
    data['ForecastCategoryName'] = this.forecastCategoryName;
    data['CloseDate'] = this.closeDate;
    data['Worked_by__c'] = this.workedByC;
    data['Origin__c'] = this.originC;
    data['Description_of_Goods__c'] = this.descriptionOfGoodsC;
    data['Packaging_Details__c'] = this.packagingDetailsC;
    data['H_S_Code__c'] = this.hSCodeC;
    data['Total_of_Containers__c'] = this.totalOfContainersC;
    data['Container_Size__c'] = this.containerSizeC;
    data['Port_of_Discharge__c'] = this.portOfDischargeC;
    data['Business_Entity__c'] = this.businessEntityC;
    return data;
  }
}

class OpportunityAttributes {
  String? type;
  String? url;

  OpportunityAttributes({this.type, this.url});

  OpportunityAttributes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class Account {
  OpportunityAttributes? attributes;
  String? name;

  Account({this.attributes, this.name});

  Account.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new OpportunityAttributes.fromJson(json['attributes'])
        : null;
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    data['Name'] = this.name;
    return data;
  }
}
