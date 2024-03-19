import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/home_entities/home_entity.dart';

abstract class HomeRepository {
  Future<DataState<HomeEntity>> getHomeData();
}
