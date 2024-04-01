import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/all_product_entities/all_product_entity.dart';

class ProductLazyLoadEntity extends Equatable {
  final List<AllProductEntities> productPayload;
  final String nextPayload;
  final int total;

  const ProductLazyLoadEntity({
    required this.productPayload,
    required this.nextPayload,
    required this.total,
  });

  @override
  List<Object?> get props => [productPayload, nextPayload, total];
}
