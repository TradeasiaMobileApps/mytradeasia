import 'package:mytradeasia/features/domain/entities/all_product_entities/lazy_load_list_product.dart';

import '../../../core/resources/data_state.dart';

abstract class ListProductRepository {
  Future<DataState<ProductLazyLoadEntity>> getListProduct(String? nextPayload);
}
