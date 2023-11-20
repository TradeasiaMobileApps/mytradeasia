import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_opportunity_model.dart';

abstract class SalesforceDataEvent {
  const SalesforceDataEvent();
}

class GetDataSalesforce extends SalesforceDataEvent {
  final String token;
  const GetDataSalesforce(this.token);
}

class GetCPSalesforce extends SalesforceDataEvent {
  final String userId;
  const GetCPSalesforce(this.userId);
}

class CreateSFAccount extends SalesforceDataEvent {
  final String token;
  final SalesforceCreateAccountForm salesforceCreateAccountForm;

  CreateSFAccount(
      {required this.token, required this.salesforceCreateAccountForm});
}

class CreateSFOpportunity extends SalesforceDataEvent {
  final SalesforceCreateOpportunityForm salesforceCreateOpportunityForm;

  CreateSFOpportunity(this.salesforceCreateOpportunityForm);
}
