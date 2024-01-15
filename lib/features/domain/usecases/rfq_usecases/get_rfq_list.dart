import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetRfqList implements UseCase<DataState<List<RfqEntity>>, void> {
  final RfqRepository _rfqRepository;

  GetRfqList(this._rfqRepository);

  @override
  Future<DataState<List<RfqEntity>>> call({void param}) {
    return _rfqRepository.getRfqList();
  }
}
