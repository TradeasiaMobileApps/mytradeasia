import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/quote_entities/quote_entity.dart';
import 'package:mytradeasia/features/domain/repository/quote_repository.dart';
import 'package:mytradeasia/features/data/data_sources/remote/quote_service.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteService _quoteService;

  QuoteRepositoryImpl(this._quoteService);

  @override
  Future<DataState<QuoteEntity>> getQuote(int id) async {
    try {
      final response = await _quoteService.getQuote(id);
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
