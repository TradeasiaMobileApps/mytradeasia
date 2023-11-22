import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/country_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../entities/country_entities/country_entity.dart';

class SearchCountryUsecase
    implements UseCase<DataState<List<CountryEntity>>, String> {
  CountryRepository _countryRepository;

  SearchCountryUsecase(this._countryRepository);

  @override
  Future<DataState<List<CountryEntity>>> call({required String param}) {
    return _countryRepository.searchCountry(param);
  }
}
