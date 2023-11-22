import 'package:mytradeasia/features/domain/repository/country_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/country_entities/country_entity.dart';

class GetCountryUsecase
    implements UseCase<DataState<List<CountryEntity>>, void> {
  CountryRepository _countryRepository;

  GetCountryUsecase(this._countryRepository);

  @override
  Future<DataState<List<CountryEntity>>> call({void param}) {
    return _countryRepository.getCountry();
  }
}
