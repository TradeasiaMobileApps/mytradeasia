import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/submit_rfq.dart';

import 'rfq_event.dart';
import 'rfq_state.dart';

class RfqBloc extends Bloc<RfqEvent, RfqState> {
  final SubmitRfqUseCase _submitRfq;

  RfqBloc(this._submitRfq) : super(RfqInitial()) {
    on<SubmitRfqEvent>((event, emit) async {
      final response = await _submitRfq.call(param: event.rfqEntity);
      emit(const RfqLoading());
      if (response is DataSuccess) {
        emit(const RfqSuccess("rfq-submit-success"));
      }

      if (response is DataFailed) {
        emit(RfqError(response.error!));
      }
    });
    on<DisposeRfq>((event, emit) async {
      emit(RfqInitial());
    });
  }
}
