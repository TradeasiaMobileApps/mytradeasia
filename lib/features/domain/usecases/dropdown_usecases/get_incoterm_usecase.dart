import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_incoterm_entity.dart';
import 'package:mytradeasia/features/domain/repository/dropdown_repository.dart';

class GetIncotermUsecase
    implements UseCase<DataState<List<DropdownIncotermEntity>>, void> {
  final DropdownRepository _dropdownRepository;

  GetIncotermUsecase(this._dropdownRepository);

  @override
  Future<DataState<List<DropdownIncotermEntity>>> call({void param}) async {
    return _dropdownRepository.getIncoterm();
  }
}
