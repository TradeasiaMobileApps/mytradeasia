import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/data/data_sources/remote/sales_force_data_service.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_opportunity_model.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_cp_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_account_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_opportunity_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_data_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_opportunity_entity.dart';
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
  Future<DataState<SalesforceCPEntity>> getSalesforceCP(String userId) async {
    try {
      final response = await _salesforceDataService.getCostPrice(userId);
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
  Future<DataState<SalesforceCreateAccountEntity>> createSalesforceAccount({
    required String? token,
    required String? firstName,
    required String? lastName,
    required String? phone,
    required String? role,
    required String? company,
    required String? email,
    required String? country,
  }) async {
    try {
      final response = await _salesforceDataService.createSFAccount(
        token: token,
        firstName: firstName,
        role: role,
        company: company,
        phone: phone,
        lastName: lastName,
        email: email,
        country: country,
      );
      if (response.statusCode == HttpStatus.created) {
        // String docsId = FirebaseAuth.instance.currentUser!.uid.toString();
        // await FirebaseFirestore.instance
        //     .collection('biodata')
        //     .doc(docsId)
        //     .update({"idSF": response.data != null ? response.data!.id : ""});
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
  Future<DataState<SalesforceCreateOpportunityEntity>>
      createSalesforceOpportunity(
          SalesforceCreateOpportunityForm formData) async {
    try {
      final response = await _salesforceDataService.createSFOpp(formData);
      if (response.statusCode == HttpStatus.created) {
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
  Future<DataState<SalesforceOpportunityEntity>> getSalesforceOpportunity(
      String id) async {
    try {
      final response = await _salesforceDataService.getSFOpp(id);
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
