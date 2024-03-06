import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/category_service.dart';
import 'package:mytradeasia/features/domain/entities/category_entities/category_entity.dart';
import 'package:mytradeasia/features/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepositoryImpl(this._categoryService);

  @override
  Future<DataState<List<CategoryIndustry>>> getCategory() async {
    try {
      final response = await _categoryService.getCategories();
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data!);
      } else {
        return DataFailed(DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
