import 'package:dio/dio.dart';

abstract class RfqState {
  final String? response;
  final DioException? error;

  const RfqState({this.response, this.error});
}

class RfqInitial extends RfqState {}

class RfqLoading extends RfqState {
  const RfqLoading();
}

class RfqSuccess extends RfqState {
  const RfqSuccess(String response) : super(response: response);
}

class RfqError extends RfqState {
  const RfqError(DioException error) : super(error: error);
}
