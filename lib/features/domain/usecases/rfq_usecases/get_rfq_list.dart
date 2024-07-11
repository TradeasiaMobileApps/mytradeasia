import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_list_entity.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetRfqList implements UseCase<DataState<RfqListEntity>, void> {
  final RfqRepository _rfqRepository;

  GetRfqList(this._rfqRepository);

  @override
  Future<DataState<RfqListEntity>> call({void param}) {
    return _rfqRepository.getRfqList();
  }
}
