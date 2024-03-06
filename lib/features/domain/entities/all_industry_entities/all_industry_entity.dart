import 'package:equatable/equatable.dart';

class AllIndustryEntity extends Equatable {
  const AllIndustryEntity({
    required this.detailIndustry,
  });

  final List<DetailIndustry>? detailIndustry;

  @override
  List<Object?> get props => [detailIndustry];
}

class DetailIndustry {
  const DetailIndustry({
    required this.industryId,
    required this.industryName,
    required this.industryImage,
  });

  final String? industryId;
  final String? industryName;
  final String? industryImage;
}

// class Category {
//   const Category({
//     required this.categoryName,
//     required this.seoUrl,
//   });

//   final String? categoryName;
//   final String? seoUrl;
// }
