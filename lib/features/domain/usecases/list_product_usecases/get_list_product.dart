import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/all_product_entities/lazy_load_list_product.dart';
import 'package:mytradeasia/features/domain/repository/list_product_repository.dart';

class GetListProduct
    implements UseCase<DataState<ProductLazyLoadEntity>, String?> {
  final ListProductRepository _listProductRepository;

  GetListProduct(this._listProductRepository);

  @override
  Future<DataState<ProductLazyLoadEntity>> call({required String? param}) {
    return _listProductRepository.getListProduct(param);
  }
}
