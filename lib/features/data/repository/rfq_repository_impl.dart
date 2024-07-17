import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/rfq_service.dart';
import 'package:mytradeasia/features/data/model/rfq_models/request_model.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/request_entity.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_list_entity.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

class RfqRepositoryImpl implements RfqRepository {
  final RfqService _rfqService;

  RfqRepositoryImpl(this._rfqService);

  @override
  Future<DataState> submitRfq(RequestEntity s) async {
    try {
      final response = await _rfqService.submitRfqService(
        RequestModel(
          productId: s.productId,
          uomId: s.uomId,
          qty: s.qty,
          incoterm: s.incoterm,
          pod: s.pod,
          firstName: s.firstName,
          lastName: s.lastName,
          companyName: s.companyName,
          country: s.country,
          dialingCode: s.dialingCode,
          mobileNumber: s.mobileNumber,
          email: s.email,
        ),
      );

      if (response!.statusCode == HttpStatus.ok) {
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
  Future<DataState<RfqListEntity>> getRfqList() async {
    try {
      final response = await _rfqService.getRfqList();

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
  Future<DataState> approveQuote(int id) async {
    try {
      final response = await _rfqService.approveQuote(id);

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
  Future<DataState> rejectQuote(int id) async {
    try {
      final response = await _rfqService.rejectQuote(id);

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
