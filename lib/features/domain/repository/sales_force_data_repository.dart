import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_cp_entity.dart';
import 'package:mytradeasia/features/domain/entities/sales_force_data_entities/sales_force_data_entity.dart';

abstract class SalesForceDataRepository {
  Future<DataState<SalesforceDataEntity>> getSalesForceData(String s);
  Future<DataState<SalesforceCPEntity>> getSalesforceCP(String token);
}
