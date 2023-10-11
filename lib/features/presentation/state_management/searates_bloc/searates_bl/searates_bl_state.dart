import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';

abstract class SearatesBLState extends Equatable {
  final SearatesBLEntity? data;
  final DioException? error;

  const SearatesBLState({this.data, this.error});

  @override
  List<Object?> get props => [data, error];
}

class SearatesBLLoading extends SearatesBLState {
  const SearatesBLLoading();
}

class SearatesBLDone extends SearatesBLState {
  const SearatesBLDone(SearatesBLEntity data) : super(data: data);
}

class SearatesBLError extends SearatesBLState {
  const SearatesBLError(DioException error) : super(error: error);
}
