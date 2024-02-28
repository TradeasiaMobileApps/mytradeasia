import 'package:equatable/equatable.dart';

class DetailsProductEntity extends Equatable {
  const DetailsProductEntity({
    required this.detailProduct,
    required this.listIndustry,
    required this.relatedProducts,
    required this.basicInfo,
  });

  final DetailProduct? detailProduct;
  final List<ListIndustry>? listIndustry;
  final List<RelatedProduct>? relatedProducts;
  final BasicInfo? basicInfo;

  @override
  List<Object?> get props {
    return [
      detailProduct,
      listIndustry,
      relatedProducts,
      basicInfo,
    ];
  }
}

class DetailProduct {
  const DetailProduct({
    required this.productId,
    required this.productname,
    required this.productimage,
    required this.iupacName,
    required this.casNumber,
    required this.hsCode,
    required this.formula,
    required this.description,
    required this.application,
    required this.packagingName,
    required this.categoryName,
  });

  final String? productId;
  final String? productname;
  final String? productimage;
  final String? iupacName;
  final String? casNumber;
  final String? hsCode;
  final String? formula;
  final String? description;
  final String? application;
  final String? packagingName;
  final String? categoryName;
}

class ListIndustry {
  const ListIndustry({
    required this.industryId,
    required this.industryUrl,
    required this.industryName,
  });

  final String? industryId;
  final String? industryUrl;
  final String? industryName;
}

class RelatedProduct {
  const RelatedProduct({
    required this.productId,
    required this.productname,
    required this.productimage,
    required this.casNumber,
    required this.hsCode,
  });

  final String? productId;
  final String? productname;
  final String? productimage;
  final String? casNumber;
  final String? hsCode;
}

class BasicInfo {
  final String? phy_appear_name;
  final String? packaging_name;
  final String? common_names;

  const BasicInfo({
    required this.phy_appear_name,
    required this.packaging_name,
    required this.common_names,
  });
}
