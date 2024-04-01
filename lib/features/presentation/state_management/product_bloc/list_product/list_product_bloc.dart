import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/all_product_entities/lazy_load_list_product.dart';
import 'package:mytradeasia/features/domain/usecases/list_product_usecases/get_list_product.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/list_product/list_product_event.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/list_product/list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final GetListProduct _getListProduct;

  ListProductBloc(this._getListProduct) : super(const ListProductLoading()) {
    on<GetProducts>(onGetProducts);
    on<DisposeProducts>(onDisposeProducts);
  }

  void onGetProducts(GetProducts event, Emitter<ListProductState> emit) async {
    final dataState = await _getListProduct(param: event.nextPayload);

    if (dataState is DataSuccess && dataState.data != null) {
      if (event.nextPayload == null) {
        emit(ListProductDone(dataState.data!));
      } else {
        event.currentPayload!.productPayload
            .addAll(dataState.data!.productPayload);
        final ProductLazyLoadEntity product = ProductLazyLoadEntity(
            productPayload: event.currentPayload!.productPayload,
            nextPayload: dataState.data!.nextPayload,
            total: dataState.data!.total);

        emit(ListProductDone(product));
      }
    }

    if (dataState is DataFailed) {
      emit(ListProductError(dataState.error!));
    }
  }

  void onDisposeProducts(
      DisposeProducts event, Emitter<ListProductState> emit) {
    emit(const ListProductLoading());
  }
}
