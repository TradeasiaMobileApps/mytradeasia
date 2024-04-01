import 'package:mytradeasia/features/data/model/all_product_models/all_product_model.dart';
import 'package:mytradeasia/features/domain/entities/all_product_entities/lazy_load_list_product.dart';

class ProductLazyLoadModel extends ProductLazyLoadEntity {
  const ProductLazyLoadModel({
    required List<AllProductModel> productPayload,
    required String nextPayload,
    required int total,
  }) : super(
          productPayload: productPayload,
          nextPayload: nextPayload,
          total: total,
        );

  factory ProductLazyLoadModel.fromJson(Map<String, dynamic> json) =>
      ProductLazyLoadModel(
        productPayload: List<AllProductModel>.from(
            json["data"].map((e) => AllProductModel.fromJson(e))),
        nextPayload: json["next_page_url"],
        total: json["total"],
      );
}
