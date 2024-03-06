import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/category_entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  final List<CategoryIndustry>? categoryIndustry;
  final DioException? error;

  const CategoryState({this.categoryIndustry, this.error});

  @override
  List<Object> get props => [categoryIndustry!, error!];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryDone extends CategoryState {
  const CategoryDone(List<CategoryIndustry> categoryIndustry)
      : super(categoryIndustry: categoryIndustry);
}

class CategoryError extends CategoryState {
  const CategoryError(DioException error) : super(error: error);
}
