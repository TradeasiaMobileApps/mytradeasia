import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/sales_force_data_service.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_cp_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_account_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_data_entity.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_data_repository.dart';

class SalesforceDataRepositoryImpl implements SalesForceDataRepository {
  final SalesforceDataService _salesforceDataService;

  SalesforceDataRepositoryImpl(this._salesforceDataService);

  @override
  Future<DataState<SalesforceDataEntity>> getSalesForceData(
      String token) async {
    try {
      final response = await _salesforceDataService.getAllData(token);
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
  Future<DataState<SalesforceCPEntity>> getSalesforceCP(String token) async {
    try {
      final response = await _salesforceDataService.getCostPrice(token);
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
  Future<DataState<SalesforceCreateAccountEntity>> createSalesforceAccount(
      {required String? token,
      required String? name,
      required String? phone,
      required String? role,
      required String? company}) async {
    try {
      final response = await _salesforceDataService.createSFAccount(
          token: token, name: name, role: role, company: company, phone: phone);
      if (response.statusCode == HttpStatus.created) {
        String docsId = FirebaseAuth.instance.currentUser!.uid.toString();
        await FirebaseFirestore.instance
            .collection('biodata')
            .doc(docsId)
            .update({"idSF": response.data != null ? response.data!.id : ""});
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
