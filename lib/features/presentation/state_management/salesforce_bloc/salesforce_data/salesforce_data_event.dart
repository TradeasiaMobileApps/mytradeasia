import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_create_account_model.dart';

abstract class SalesforceDataEvent {
  const SalesforceDataEvent();
}

class GetDataSalesforce extends SalesforceDataEvent {
  final String token;
  const GetDataSalesforce(this.token);
}

class GetCPSalesforce extends SalesforceDataEvent {
  final String token;
  const GetCPSalesforce(this.token);
}

class CreateSFAccount extends SalesforceDataEvent {
  final String token;
  final SalesforceCreateAccountForm salesforceCreateAccountForm;

  CreateSFAccount(
      {required this.token, required this.salesforceCreateAccountForm});
}
