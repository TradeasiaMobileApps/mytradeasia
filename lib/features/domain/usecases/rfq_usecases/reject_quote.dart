import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class RejectQuote implements UseCase<DataState, int> {
  final RfqRepository _rfqRepository;

  RejectQuote(this._rfqRepository);

  ///param refer to rfq_id
  @override
  Future<DataState> call({required int param}) async {
    return await _rfqRepository.rejectQuote(param);
  }
}
