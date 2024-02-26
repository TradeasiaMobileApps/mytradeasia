import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_opportunity_entity.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_data_repository.dart';

class GetSalesForceOpportunity
    implements UseCase<DataState<SalesforceOpportunityEntity>, String> {
  final SalesForceDataRepository _salesForceDataRepository;

  GetSalesForceOpportunity(this._salesForceDataRepository);

  @override
  Future<DataState<SalesforceOpportunityEntity>> call({required String param}) {
    return _salesForceDataRepository.getSalesforceOpportunity(param);
  }
}
