import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_account_entity.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_data_repository.dart';

class CreateSalesForceAccount
    implements
        UseCaseTwoParams<DataState<SalesforceCreateAccountEntity>, String,
            SalesforceCreateAccountForm> {
  final SalesForceDataRepository _salesForceDataRepository;

  CreateSalesForceAccount(this._salesForceDataRepository);

  @override
  Future<DataState<SalesforceCreateAccountEntity>> call(
      {required String paramsOne,
      required SalesforceCreateAccountForm paramsTwo}) {
    return _salesForceDataRepository.createSalesforceAccount(
        token: paramsOne,
        name: paramsTwo.name,
        phone: paramsTwo.phone,
        role: paramsTwo.role,
        company: paramsTwo.company);
  }
}
