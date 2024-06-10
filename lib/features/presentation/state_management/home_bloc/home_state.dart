import 'package:dio/dio.dart';
import 'package:mytradeasia/features/domain/entities/home_entities/home_entity.dart';

abstract class HomeState {
  final HomeEntity? homeData;
  final DioException? error;

  const HomeState({this.homeData, this.error});
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
