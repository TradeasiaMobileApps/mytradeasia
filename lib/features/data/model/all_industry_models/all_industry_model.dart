import 'package:mytradeasia/features/domain/entities/all_industry_entities/all_industry_entity.dart';

class AllIndustryModel extends AllIndustryEntity {
  const AllIndustryModel({
    List<_DetailIndustryModel>? detailIndustryModel,
  }) : super(detailIndustry: detailIndustryModel);

  factory AllIndustryModel.fromJson(Map<String, dynamic> json) =>
      AllIndustryModel(
        detailIndustryModel: List<_DetailIndustryModel>.from(
            json["product_by_industry"]
                .map((x) => _DetailIndustryModel.fromJson(x))),
      );
}

class _DetailIndustryModel extends DetailIndustry {
  const _DetailIndustryModel({
    String? industryId,
    String? industryName,
    String? industryImage,
  }) : super(
          industryId: industryId,
          industryName: industryName,
          industryImage: industryImage,
        );

  factory _DetailIndustryModel.fromJson(Map<String, dynamic> json) =>
      _DetailIndustryModel(
        industryId: json["id"].toString(),
        industryName: json["prodind_name"],
        industryImage: json["prodind_image"],
      );
}
