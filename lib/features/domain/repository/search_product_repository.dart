import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';

abstract class SearchProductRepo {
  Future<DataState<List<ProductEntity>>> getSearchProduct(String s);
}
