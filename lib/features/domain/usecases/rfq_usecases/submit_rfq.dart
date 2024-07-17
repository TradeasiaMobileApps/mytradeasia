import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/request_entity.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

class SubmitRfqUseCase implements UseCase<DataState<dynamic>, RequestEntity> {
  final RfqRepository _rfqRepository;

  SubmitRfqUseCase(this._rfqRepository);

  @override
  Future<DataState> call({required RequestEntity param}) {
    return _rfqRepository.submitRfq(param);
  }
}
