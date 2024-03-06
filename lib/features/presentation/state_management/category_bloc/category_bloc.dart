import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/category_usecases/get_category_usecases.dart';
import 'package:mytradeasia/features/presentation/state_management/category_bloc/category_event.dart';
import 'package:mytradeasia/features/presentation/state_management/category_bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase _getCategoryUseCase;

  CategoryBloc(this._getCategoryUseCase) : super(const CategoryLoading()) {
    on<GetCategories>(onGetCategory);
    on<DisposeCategoryState>(onDisposeState);
  }

  void onGetCategory(GetCategories event, Emitter<CategoryState> emit) async {
    final dataState = await _getCategoryUseCase();

    if (dataState is DataSuccess) {
      emit(CategoryDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(CategoryError(dataState.error!));
    }
  }

  void onDisposeState(DisposeCategoryState event, Emitter<CategoryState> emit) {
    emit(const CategoryLoading());
  }
}
