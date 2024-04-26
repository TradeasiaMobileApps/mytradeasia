import 'package:dio/dio.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_uom_entity.dart';

abstract class DropdownUomState {
  final List<DropdownUomEntity>? dropdownUom;
  final DioException? error;

  const DropdownUomState({this.dropdownUom, this.error});
}

class DropdownUomLoading extends DropdownUomState {
  const DropdownUomLoading();
}

class DropdownUomSuccess extends DropdownUomState {
  const DropdownUomSuccess(List<DropdownUomEntity> dropdownUom)
      : super(dropdownUom: dropdownUom);
}

class DropdownUomError extends DropdownUomState {
  const DropdownUomError(DioException error) : super(error: error);
}
