import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/usecases/country_usecases/get_country_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/country_usecases/search_country_usecase.dart';

import 'countries_event.dart';
import 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetCountryUsecase _getCountryUsecase;
  final SearchCountryUsecase _searchCountryUsecase;

  CountriesBloc(this._getCountryUsecase, this._searchCountryUsecase)
      : super(const CountriesInit()) {
    on<GetCountriesEvent>((event, emit) async {
      final dataState = await _getCountryUsecase.call();

      if (dataState is DataSuccess) {
        emit(CountriesLoaded(dataState.data ?? []));
      }

      if (dataState is DataFailed) {
        emit(CountriesError(dataState.error!));
      }
    });
    on<SearchCountriesEvent>((event, emit) async {
      final dataState = await _searchCountryUsecase.call(param: event.query);
      if (dataState is DataSuccess) {
        emit(CountriesLoaded(dataState.data ?? []));
      }

      if (dataState is DataFailed) {
        emit(CountriesError(dataState.error!));
      }
    });
  }
}
