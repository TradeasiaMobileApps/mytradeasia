import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/dropdown_usecases/get_uom_usecase.dart';

import 'dropdown_uom_event.dart';
import 'dropdown_uom_state.dart';

class DropdownUomBloc extends Bloc<DropdownUomEvent, DropdownUomState> {
  final GetUomUsecase _getUomUsecase;
  DropdownUomBloc(this._getUomUsecase) : super(const DropdownUomLoading()) {
    on<GetUomEvent>(onGetUom);
  }
  void onGetUom(GetUomEvent event, Emitter<DropdownUomState> emit) async {
    final dataState = await _getUomUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DropdownUomSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(DropdownUomError(dataState.error!));
    }
  }
}
