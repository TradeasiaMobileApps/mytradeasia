import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';
import 'package:mytradeasia/features/domain/repository/searates_repository.dart';

class TrackByBL implements UseCase<DataState<SearatesBLEntity>, String> {
  final SearatesRepository _searatesRepository;

  TrackByBL(this._searatesRepository);

  @override
  Future<DataState<SearatesBLEntity>> call({required String param}) {
    return _searatesRepository.trackByBL(param);
  }
}
