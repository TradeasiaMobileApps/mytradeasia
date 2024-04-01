import 'package:mytradeasia/features/domain/entities/all_product_entities/lazy_load_list_product.dart';

abstract class ListProductEvent {
  const ListProductEvent();
}

class GetProducts extends ListProductEvent {
  final ProductLazyLoadEntity? currentPayload;
  final String? nextPayload;
  const GetProducts(this.currentPayload, this.nextPayload);
}

class DisposeProducts extends ListProductEvent {
  const DisposeProducts();
}
