import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/dropdown_service.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_currency_entity.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_incoterm_entity.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_uom_entity.dart';
import 'package:mytradeasia/features/domain/repository/dropdown_repository.dart';

class DropdownRepositoryImpl extends DropdownRepository {
  final DropdownService _dropdownService;

  DropdownRepositoryImpl(this._dropdownService);

  @override
  Future<DataState<List<DropdownCurrencyEntity>>> getCurrency() async {
    try {
      final response = await _dropdownService.getCurrency();
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

  @override
  Future<DataState<List<DropdownIncotermEntity>>> getIncoterm() async {
    try {
      final response = await _dropdownService.getIncoterm();
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

  @override
  Future<DataState<List<DropdownUomEntity>>> getUom() async {
    try {
      final response = await _dropdownService.getUom();
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
