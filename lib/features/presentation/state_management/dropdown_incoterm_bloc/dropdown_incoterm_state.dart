import 'package:dio/dio.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_incoterm_entity.dart';

abstract class DropdownIncotermState {
  final List<DropdownIncotermEntity>? dropdownIncoterm;
  final DioException? error;

  const DropdownIncotermState({this.dropdownIncoterm, this.error});
}

class DropdownIncotermLoading extends DropdownIncotermState {
  const DropdownIncotermLoading();
}

class DropdownIncotermSuccess extends DropdownIncotermState {
  const DropdownIncotermSuccess(List<DropdownIncotermEntity> dropdownIncoterm)
      : super(dropdownIncoterm: dropdownIncoterm);
}

class DropdownIncotermError extends DropdownIncotermState {
  const DropdownIncotermError(DioException error) : super(error: error);
}
