import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/dropdown_usecases/get_incoterm_usecase.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_state.dart';

import 'dropdown_incoterm_event.dart';

class DropdownIncotermBloc
    extends Bloc<DropdownIncotermEvent, DropdownIncotermState> {
  final GetIncotermUsecase _getIncotermUsecase;
  DropdownIncotermBloc(this._getIncotermUsecase)
      : super(const DropdownIncotermLoading()) {
    on<GetIncotermEvent>(onGetIncoterm);
  }

  void onGetIncoterm(
      GetIncotermEvent event, Emitter<DropdownIncotermState> emit) async {
    final dataState = await _getIncotermUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DropdownIncotermSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(DropdownIncotermError(dataState.error!));
    }
  }
}
