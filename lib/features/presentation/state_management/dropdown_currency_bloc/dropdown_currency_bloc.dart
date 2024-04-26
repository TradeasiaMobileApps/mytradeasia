import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/dropdown_usecases/get_currency_usecase.dart';

import 'dropdown_currency_event.dart';
import 'dropdown_currency_state.dart';

class DropdownCurrencyBloc
    extends Bloc<DropdownCurrencyEvent, DropdownCurrencyState> {
  final GetCurrencyUsecase _getCurrencyUsecase;
  DropdownCurrencyBloc(this._getCurrencyUsecase)
      : super(const DropdownCurrencyLoading()) {
    on<GetCurrencyEvent>(onGetCurrency);
  }
  void onGetCurrency(
      GetCurrencyEvent event, Emitter<DropdownCurrencyState> emit) async {
    final dataState = await _getCurrencyUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(DropdownCurrencySuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(DropdownCurrencyError(dataState.error!));
    }
  }
}
