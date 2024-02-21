import 'package:mytradeasia/features/domain/entities/all_product_entities/all_product_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class ListProductRepository {
  Future<DataState<List<AllProductEntities>>> getListProduct();
}
