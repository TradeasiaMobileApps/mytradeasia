import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/home_usecases/get_home_data.dart';
import 'package:mytradeasia/features/presentation/state_management/home_bloc/home_event.dart';
import 'package:mytradeasia/features/presentation/state_management/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData _getHomeData;

  HomeBloc(this._getHomeData) : super(const HomeLoading()) {
    on<GetHomeDataEvent>(onGetHomeData);
    on<DisposeHomeData>(onDisposeHomeData);
  }

  void onGetHomeData(GetHomeDataEvent event, Emitter<HomeState> emit) async {
    final dataState = await _getHomeData();

    if (dataState is DataSuccess) {
      emit(HomeDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(HomeError(dataState.error!));
    }
  }

  void onDisposeHomeData(DisposeHomeData event, Emitter<HomeState> emit) {
    emit(const HomeLoading());
  }
}
