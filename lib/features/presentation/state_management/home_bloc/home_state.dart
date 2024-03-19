import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/home_entities/home_entity.dart';

abstract class HomeState extends Equatable {
  final HomeEntity? homeData;
  final DioException? error;

  const HomeState({this.homeData, this.error});

  @override
  List<Object> get props => [homeData!, error!];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeDone extends HomeState {
  const HomeDone(HomeEntity homeEntity) : super(homeData: homeEntity);
}

class HomeError extends HomeState {
  const HomeError(DioException error) : super(error: error);
}
