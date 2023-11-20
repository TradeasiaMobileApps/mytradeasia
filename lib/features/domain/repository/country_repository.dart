import 'package:mytradeasia/features/domain/entities/country_entities/country_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class CountryRepository {
  Future<DataState<List<CountryEntity>>> getCountryRepo();
}
