import 'package:dio/dio.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_currency_entity.dart';

abstract class DropdownCurrencyState {
  final List<DropdownCurrencyEntity>? dropdownCurrency;
  final DioException? error;

  const DropdownCurrencyState({this.dropdownCurrency, this.error});
}

class DropdownCurrencyLoading extends DropdownCurrencyState {
  const DropdownCurrencyLoading();
}

class DropdownCurrencySuccess extends DropdownCurrencyState {
  const DropdownCurrencySuccess(List<DropdownCurrencyEntity> dropdownCurrency)
      : super(dropdownCurrency: dropdownCurrency);
}

class DropdownCurrencyError extends DropdownCurrencyState {
  const DropdownCurrencyError(DioException error) : super(error: error);
}
