import 'package:equatable/equatable.dart';

class CategoryIndustry extends Equatable {
  const CategoryIndustry({
    required this.industryId,
    required this.industryName,
    required this.category,
  });

  final String? industryId;
  final String? industryName;
  final List<CategoryEntity>? category;

  @override
  // TODO: implement props
  List<Object?> get props => [industryId, industryName, category];
}

class CategoryEntity {
  const CategoryEntity({
    required this.id,
    required this.categoryName,
  });

  final String? id;
  final String? categoryName;
}
