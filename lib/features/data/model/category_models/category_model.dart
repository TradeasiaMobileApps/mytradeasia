import '../../../domain/entities/category_entities/category_entity.dart';

class CategoryIndustryModel extends CategoryIndustry {
  const CategoryIndustryModel({
    String? industryId,
    String? industryName,
    List<_CategoryModel>? category,
  }) : super(
          industryId: industryId,
          industryName: industryName,
          category: category,
        );

  factory CategoryIndustryModel.fromJson(Map<String, dynamic> json) =>
      CategoryIndustryModel(
        industryId: json['id'].toString(),
        industryName: json['prodind_name'],
        category: List<_CategoryModel>.from(
            json["category"].map((x) => _CategoryModel.fromJson(x))),
      );
}

class _CategoryModel extends CategoryEntity {
  const _CategoryModel({
    String? id,
    String? categoryName,
  }) : super(
          id: id,
          categoryName: categoryName,
        );

  factory _CategoryModel.fromJson(Map<String, dynamic> json) => _CategoryModel(
        id: json['prodind_id'].toString(),
        categoryName: json['category_name'],
      );
}
