import '../../../domain/entities/all_product_entities/all_product_entity.dart';

class AllProductModel extends AllProductEntities {
  const AllProductModel({
    String? id,
    String? productname,
    String? productimage,
    String? hsCode,
    String? casNumber,
  }) : super(
          id: id,
          productname: productname,
          productimage: productimage,
          hsCode: hsCode,
          casNumber: casNumber,
        );

  factory AllProductModel.fromJson(Map<String, dynamic> json) =>
      AllProductModel(
        id: json["id"].toString(),
        productname: json["productname"],
        productimage: json["productimage"],
        hsCode: json["hs_code"],
        casNumber: json["cas_number"],
      );

  factory AllProductModel.fromFirebase(Map<String, dynamic> json) =>
      AllProductModel(
        id: json["id"].toString(),
        productname: json["productName"],
        productimage: json["productImage"],
        hsCode: json["hsCode"],
        casNumber: json["casNumber"],
      );
}
