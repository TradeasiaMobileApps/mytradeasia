import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_currency_entity.dart';
import 'package:mytradeasia/features/domain/repository/dropdown_repository.dart';

class GetCurrencyUsecase
    implements UseCase<DataState<List<DropdownCurrencyEntity>>, void> {
  final DropdownRepository _dropdownRepository;

  GetCurrencyUsecase(this._dropdownRepository);

  @override
  Future<DataState<List<DropdownCurrencyEntity>>> call({void param}) {
    return _dropdownRepository.getCurrency();
  }
}
