import 'package:mytradeasia/features/domain/entities/detail_product_entities/detail_product_entities.dart';

class DetailsProductModel extends DetailsProductEntity {
  const DetailsProductModel({
    _DetailProduct? detailProduct,
    List<_ListIndustryModel>? listIndustry,
    List<_RelatedProductModel>? relatedProducts,
    _BasicInfoModel? basicInfoModel,
  }) : super(
          detailProduct: detailProduct,
          listIndustry: listIndustry,
          relatedProducts: relatedProducts,
          basicInfo: basicInfoModel,
        );

  factory DetailsProductModel.fromJson(Map<String, dynamic> json) =>
      DetailsProductModel(
        detailProduct: json["product_detail"] != null
            ? _DetailProduct.fromJson(json["product_detail"])
            : null,
        listIndustry: List<_ListIndustryModel>.from(json["product_detail"]
                ["productIndustries"]
            .map((x) => _ListIndustryModel.fromJson(x))),
        relatedProducts: List<_RelatedProductModel>.from(json["related_product"]
            .map((x) => _RelatedProductModel.fromJson(x))),
        basicInfoModel: _BasicInfoModel.fromJson(json["basic_info"]),
      );
}

class _DetailProduct extends DetailProduct {
  const _DetailProduct({
    String? productId,
    String? productname,
    String? productimage,
    String? iupacName,
    String? casNumber,
    String? hsCode,
    String? formula,
    String? description,
    String? application,
    String? packagingName,
    String? categoryName,
  }) : super(
          productId: productId,
          productname: productname,
          productimage: productimage,
          iupacName: iupacName,
          casNumber: casNumber,
          hsCode: hsCode,
          formula: formula,
          description: description,
          application: application,
          packagingName: packagingName,
          categoryName: categoryName,
        );

  factory _DetailProduct.fromJson(Map<String, dynamic> json) => _DetailProduct(
        productname: json["productname"] ?? "",
        productimage: json["productimage"] ?? "",
        iupacName: json["iupac_name"] ?? "",
        casNumber: json["cas_number"] ?? "",
        hsCode: json["hs_code"] ?? "",
        formula: json["formula"] ?? "",
        description: json["description"] ?? "",
        application: json["application"] ?? "",
        packagingName: json["packaging_name"] ?? "",
        categoryName: json["category_name"] ?? "",
      );
}

class _ListIndustryModel extends ListIndustry {
  const _ListIndustryModel({
    String? industryId,
    String? industryUrl,
    String? industryName,
  }) : super(
          industryId: industryId,
          industryUrl: industryUrl,
          industryName: industryName,
        );

  factory _ListIndustryModel.fromJson(Map<String, dynamic> json) =>
      _ListIndustryModel(
        industryId: json["id"].toString(),
        industryUrl: json["prodind_url"],
        industryName: json["prodind_name"],
      );
}

class _RelatedProductModel extends RelatedProduct {
  const _RelatedProductModel({
    String? productId,
    String? productname,
    String? productimage,
    String? casNumber,
    String? hsCode,
  }) : super(
          productId: productId,
          productname: productname,
          productimage: productimage,
          casNumber: casNumber,
          hsCode: hsCode,
        );

  factory _RelatedProductModel.fromJson(Map<String, dynamic> json) =>
      _RelatedProductModel(
        productId: json["id"].toString(),
        productname: json["productname"],
        productimage: json["productimage"],
        casNumber: json["cas_number"],
        hsCode: json["hs_code"],
      );
}

class _BasicInfoModel extends BasicInfo {
  const _BasicInfoModel({
    String? phy_appear_name,
    String? packaging_name,
    String? common_names,
  }) : super(
          phy_appear_name: phy_appear_name,
          packaging_name: packaging_name,
          common_names: common_names,
        );

  factory _BasicInfoModel.fromJson(Map<String, dynamic> json) =>
      _BasicInfoModel(
        phy_appear_name: json["phy_appear_name"],
        packaging_name: json["packaging_name"],
        common_names: json["common_names"],
      );
}
