import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/home_service.dart';
import 'package:mytradeasia/features/domain/entities/home_entities/home_entity.dart';
import 'package:mytradeasia/features/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeService _homeService;

  HomeRepositoryImpl(this._homeService);

  @override
  Future<DataState<HomeEntity>> getHomeData() async {
    try {
      final response = await _homeService.getHomeData();
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
