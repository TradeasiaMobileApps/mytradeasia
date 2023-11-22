import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_cp_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_data_entity.dart';

abstract class SalesforceDataState extends Equatable {
  final SalesforceDataEntity? dataEntity;
  final SalesforceCPEntity? cpEntity;
  final DioException? error;

  const SalesforceDataState({this.cpEntity, this.dataEntity, this.error});

  @override
  List<Object?> get props => [dataEntity, error];
}

class SalesforceDataLoading extends SalesforceDataState {
  const SalesforceDataLoading();
}

class SalesforceDataDone extends SalesforceDataState {
  const SalesforceDataDone(SalesforceDataEntity dataEntity)
      : super(dataEntity: dataEntity);
}

class SalesforceCPDone extends SalesforceDataState {
  const SalesforceCPDone(SalesforceCPEntity cpEntity)
      : super(cpEntity: cpEntity);
}

class SalesforceDataError extends SalesforceDataState {
  const SalesforceDataError(DioException error) : super(error: error);
}
