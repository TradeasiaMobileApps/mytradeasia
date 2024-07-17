import 'package:mytradeasia/features/domain/entities/rfq_entities/request_entity.dart';

class RequestModel extends RequestEntity {
  const RequestModel({
    int? productId,
    int? uomId,
    int? qty,
    String? incoterm,
    String? pod,
    String? firstName,
    String? lastName,
    String? companyName,
    String? country,
    String? dialingCode,
    String? mobileNumber,
    String? email,
  }) : super(
          productId: productId,
          uomId: uomId,
          qty: qty,
          incoterm: incoterm,
          pod: pod,
          firstName: firstName,
          lastName: lastName,
          companyName: companyName,
          country: country,
          dialingCode: dialingCode,
          mobileNumber: mobileNumber,
          email: email,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['product_id'] = productId;
    json['uom_id'] = uomId;
    json['qty'] = qty;
    json['incoterm'] = incoterm;
    json['pod'] = pod;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['company_name'] = companyName;
    json['country'] = country;
    json['dialing_code'] = dialingCode;
    json['mobile_number'] = mobileNumber;
    json['email'] = email;
    return json;
  }
}
