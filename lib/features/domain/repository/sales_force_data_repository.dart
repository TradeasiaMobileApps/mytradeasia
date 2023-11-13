import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_cp_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_create_account_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_data_entity.dart';

abstract class SalesForceDataRepository {
  Future<DataState<SalesforceDataEntity>> getSalesForceData(String s);

  Future<DataState<SalesforceCPEntity>> getSalesforceCP(String token);

  Future<DataState<SalesforceCreateAccountEntity>> createSalesforceAccount(
      {required String? token,
      required String? name,
      required String? phone,
      required String? role,
      required String? company});
}
