import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';

class SearchProductModel extends ProductEntity {
  const SearchProductModel({
    String? productname,
    String? productimage,
    String? hsCode,
    String? casNumber,
  }) : super(
          productname: productname,
          productimage: productimage,
          hsCode: hsCode,
          casNumber: casNumber,
        );

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        productname: json["productname"],
        productimage: json["productimage"],
        hsCode: json["hs_code"],
        casNumber: json["cas_number"],
      );
}
