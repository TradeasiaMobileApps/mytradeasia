import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

class RfqModel extends RfqEntity {
  const RfqModel(
      {required int? rfqId,
      required int custId,
      int? salesId,
      String? firstname,
      String? lastname,
      String? phone,
      String? country,
      String? company,
      RfqProductModel? products,
      String? incoterm,
      String? portOfDestination,
      String? message,
      String? quotationStatus})
      : super(
            rfqId: rfqId,
            custId: custId,
            salesId: salesId,
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            country: country,
            company: company,
            products: products,
            incoterm: incoterm,
            portOfDestination: portOfDestination,
            message: message,
            quotationStatus: quotationStatus);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['customer_id'] = custId;
    json['firstname'] = firstname;
    json['lastname'] = lastname;
    json['phone'] = phone;
    json['country'] = country;
    json['company'] = company;
    json['product_name'] = products!.productName;
    json['quantity'] = products!.quantity;
    json['unit'] = products!.unit;
    json['incoterm'] = incoterm;
    json['port_of_destination'] = portOfDestination;
    json['message'] = message;
    return json;
  }

  factory RfqModel.fromJson(Map<String, dynamic> json) => RfqModel(
        rfqId: json['id'],
        custId: json['customer_id'],
        salesId: json['sales_id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        company: json['company'],
        country: json['country'],
        incoterm: json['incoterm'],
        message: json['message'],
        phone: json['phone'],
        portOfDestination: json['port_of_destination'],
        products: RfqProductModel(
          productName: json['product_name'],
          quantity: json['quantity'],
          unit: json['unit'],
        ),
        quotationStatus: json['quotation_status'],
      );
}

class RfqProductModel extends RfqProduct {
  const RfqProductModel({
    String? productName,
    double? quantity,
    String? unit,
  }) : super(
          productName: productName,
          quantity: quantity,
          unit: unit,
        );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['product_name'] = productName;
    json['quantity'] = quantity;
    json['unit'] = unit;
    return json;
  }
}
