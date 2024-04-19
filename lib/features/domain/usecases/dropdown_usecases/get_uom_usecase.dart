import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_uom_entity.dart';
import 'package:mytradeasia/features/domain/repository/dropdown_repository.dart';

class GetUomUsecase
    implements UseCase<DataState<List<DropdownUomEntity>>, void> {
  final DropdownRepository _dropdownRepository;

  GetUomUsecase(this._dropdownRepository);

  @override
  Future<DataState<List<DropdownUomEntity>>> call({void param}) {
    return _dropdownRepository.getUom();
  }
}
