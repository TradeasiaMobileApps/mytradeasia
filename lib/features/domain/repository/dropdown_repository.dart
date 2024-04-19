import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_currency_entity.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_incoterm_entity.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_uom_entity.dart';

abstract class DropdownRepository {
  Future<DataState<List<DropdownIncotermEntity>>> getIncoterm();
  Future<DataState<List<DropdownUomEntity>>> getUom();
  Future<DataState<List<DropdownCurrencyEntity>>> getCurrency();
}
