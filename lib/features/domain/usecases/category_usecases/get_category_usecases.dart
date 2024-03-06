import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/category_entities/category_entity.dart';
import 'package:mytradeasia/features/domain/repository/category_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetCategoryUseCase
    implements UseCase<DataState<List<CategoryIndustry>>, void> {
  final CategoryRepository _categoryRepository;

  GetCategoryUseCase(this._categoryRepository);

  @override
  Future<DataState<List<CategoryIndustry>>> call({void param}) async {
    return await _categoryRepository.getCategory();
  }
}
