import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_opportunity_model.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_opportunity_entity.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_data_repository.dart';

class CreateSalesForceOpportunity
    implements
        UseCase<DataState<SalesforceCreateOpportunityEntity>,
            SalesforceCreateOpportunityForm> {
  final SalesForceDataRepository _salesForceDataRepository;

  CreateSalesForceOpportunity(this._salesForceDataRepository);

  @override
  Future<DataState<SalesforceCreateOpportunityEntity>> call(
      {required SalesforceCreateOpportunityForm param}) {
    return _salesForceDataRepository.createSalesforceOpportunity(param);
  }
}
