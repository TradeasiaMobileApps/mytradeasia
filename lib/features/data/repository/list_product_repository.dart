import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/list_product_service.dart';
import 'package:mytradeasia/features/data/model/all_product_models/lazy_load_list_product_model.dart';

import 'package:mytradeasia/features/domain/repository/list_product_repository.dart';

class ListProductRepositoryImpl implements ListProductRepository {
  final ListProductService _listProductService;

  ListProductRepositoryImpl(this._listProductService);

  @override
  Future<DataState<ProductLazyLoadModel>> getListProduct(
      String? nextPayload) async {
    try {
      final response = await _listProductService.getListProduct(nextPayload);

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
