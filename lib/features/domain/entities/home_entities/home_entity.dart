import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/all_industry_entities/all_industry_entity.dart';
import 'package:mytradeasia/features/domain/entities/all_product_entities/all_product_entity.dart';
import 'package:mytradeasia/features/domain/entities/top_products_entities/top_products_entity.dart';

class HomeEntity extends Equatable {
  final List<TopProductEntity>? topProduct;
  final AllIndustryEntity? byIndustry;
  final List<AllProductEntities>? recentlySeen;

  const HomeEntity({
    required this.topProduct,
    required this.byIndustry,
    required this.recentlySeen,
  });

  @override
  List<Object?> get props => [topProduct, byIndustry, recentlySeen];
}
