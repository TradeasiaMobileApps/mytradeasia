import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_cp_entity.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_data_repository.dart';

class GetSalesForceCP
    implements UseCase<DataState<SalesforceCPEntity>, String> {
  final SalesForceDataRepository _salesForceDataRepository;

  GetSalesForceCP(this._salesForceDataRepository);

  @override
  Future<DataState<SalesforceCPEntity>> call({required String? param}) {
    return _salesForceDataRepository.getSalesforceCP(param!);
  }
}
