import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/home_entities/home_entity.dart';
import 'package:mytradeasia/features/domain/repository/home_repository.dart';

class GetHomeData implements UseCase<DataState<HomeEntity>, void> {
  final HomeRepository _homeRepository;

  GetHomeData(this._homeRepository);

  @override
  Future<DataState<HomeEntity>> call({void param}) {
    return _homeRepository.getHomeData();
  }
}
