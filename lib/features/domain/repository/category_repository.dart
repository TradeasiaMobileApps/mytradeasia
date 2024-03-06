import 'package:mytradeasia/features/domain/entities/category_entities/category_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class CategoryRepository {
  Future<DataState<List<CategoryIndustry>>> getCategory();
}
