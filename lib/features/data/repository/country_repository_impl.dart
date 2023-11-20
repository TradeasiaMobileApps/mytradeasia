import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/country_service.dart';

import 'package:mytradeasia/features/domain/entities/country_entities/country_entity.dart';

import '../../domain/repository/country_repository.dart';

class CountryRepoImpl implements CountryRepository {
  final CountryService _countryService;

  CountryRepoImpl(this._countryService);

  @override
  Future<DataState<List<CountryEntity>>> getCountryRepo() async {
    try {
      final response = await _countryService.getListCountries();

      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data!);
      } else {
        return DataFailed(DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
