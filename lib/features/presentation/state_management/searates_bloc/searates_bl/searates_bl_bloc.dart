import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/searates_usecases/track_by_bl.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_bl/searates_bl_event.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_bl/searates_bl_state.dart';

class SearatesBLBloc extends Bloc<SearatesBLEvent, SearatesBLState> {
  final TrackByBL _trackByBL;

  SearatesBLBloc(this._trackByBL) : super(const SearatesBLLoading()) {
    on<TrackByBLNumber>(onTrackByBL);
  }
  void onTrackByBL(TrackByBLNumber event, Emitter<SearatesBLState> emit) async {
    final dataState = await _trackByBL(param: event.number);
    if (dataState is DataSuccess) {
      emit(SearatesBLDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(SearatesBLError(dataState.error!));
    }
  }
}
