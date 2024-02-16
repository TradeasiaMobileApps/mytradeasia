import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

import '../../../../core/resources/data_state.dart';

class ApproveQuote implements UseCase<DataState, int> {
  final RfqRepository _rfqRepository;

  ApproveQuote(this._rfqRepository);

  ///Param refer to rfq_id
  @override
  Future<DataState> call({required int param}) async {
    return await _rfqRepository.approveQuote(param);
  }
}
