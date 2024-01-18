import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

abstract class QuotationState extends Equatable {
  final List<RfqEntity>? rfq;
  final DioException? error;

  const QuotationState({this.rfq, this.error});
  @override
  List<Object> get props => [rfq!, error!];
}

class InitialQuotations extends QuotationState {
  const InitialQuotations(List<RfqEntity> rfq) : super(rfq: rfq);
}

class LoadingQuotations extends QuotationState {
  const LoadingQuotations();
}

class QuotationDone extends QuotationState {
  const QuotationDone(List<RfqEntity> rfq) : super(rfq: rfq);
}

class QuotationError extends QuotationState {
  const QuotationError(DioException error) : super(error: error);
}
