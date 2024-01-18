import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/get_rfq_list.dart';

import '../../../../core/resources/data_state.dart';
import 'quotations_event.dart';
import 'quotations_state.dart';

class QuotationBloc extends Bloc<QuotationEvent, QuotationState> {
  final GetRfqList _getRfqList;

  QuotationBloc(this._getRfqList) : super(const InitialQuotations([])) {
    on<GetRFQs>(onGetQuotation);
    on<DisposeQuotation>(onDisposeQuotation);
  }

  void onGetQuotation(GetRFQs event, Emitter<QuotationState> emit) async {
    final dataState = await _getRfqList();

    print(dataState.data!);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print("success called");
      emit(QuotationDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(QuotationError(dataState.error!));
    }
  }

  void onDisposeQuotation(
      DisposeQuotation event, Emitter<QuotationState> emit) {
    print("dispose called");
    emit(const InitialQuotations([]));
  }
}
