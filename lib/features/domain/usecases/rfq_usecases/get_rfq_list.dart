import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';

class GetRfqList implements UseCase<void, void> {
  final RfqRepository _rfqRepository;

  GetRfqList(this._rfqRepository);

  @override
  Future<void> call({void param}) async {
    _rfqRepository.getRfqList();
    return;
  }
}
