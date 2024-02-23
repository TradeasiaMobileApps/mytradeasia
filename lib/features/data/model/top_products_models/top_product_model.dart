import 'package:mytradeasia/features/domain/entities/top_products_entities/top_products_entity.dart';

class TopProductsModel extends TopProductEntity {
  const TopProductsModel({
    int? productId,
    String? productimage,
    String? productname,
    String? casNumber,
    String? hsCode,
    String? seoUrl,
  }) : super(
          productId: productId,
          productimage: productimage,
          productname: productname,
          casNumber: casNumber,
          hsCode: hsCode,
        );

  factory TopProductsModel.fromJson(Map<String, dynamic> json) =>
      TopProductsModel(
        productId: json["id"],
        productimage: json["productimage"],
        productname: json["productname"],
        casNumber: json["cas_number"],
        hsCode: json["hs_code"],
        seoUrl: json["seo_url"],
      );
}
