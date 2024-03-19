import 'package:mytradeasia/features/data/model/all_industry_models/all_industry_model.dart';
import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';
import 'package:mytradeasia/features/data/model/top_products_models/top_product_model.dart';
import 'package:mytradeasia/features/domain/entities/home_entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    List<TopProductsModel>? topProduct,
    AllIndustryModel? byIndustry,
    List<AllProductModel>? recentlySeen,
  }) : super(
          topProduct: topProduct,
          byIndustry: byIndustry,
          recentlySeen: recentlySeen,
        );

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    List topProdJson = json["top_product"] as List;
    var byIndustryJson = AllIndustryModel.fromJson(json);
    List recentSeenJson = json["recently_viewed_product"] as List;
    return HomeModel(
        topProduct:
            topProdJson.map((e) => TopProductsModel.fromJson(e)).toList(),
        byIndustry: byIndustryJson,
        recentlySeen:
            recentSeenJson.map((e) => AllProductModel.fromJson(e)).toList());
  }
}
