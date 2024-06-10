import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/all_product_entities/all_product_entity.dart';

abstract class RecentlySeenState extends Equatable {
  //using allproductentity for object model
  final List<AllProductEntities>? products;
  final DioException? error;

  const RecentlySeenState({
    this.products,
    this.error,
  });

  @override
  List<Object?> get props => [
        products!,
      ];
}

class RecentlySeenInit extends RecentlySeenState {
  const RecentlySeenInit();
}

class RecentlySeenDone extends RecentlySeenState {
  const RecentlySeenDone(List<AllProductEntities> product)
      : super(products: product);
}

class RecentlySeenError extends RecentlySeenState {
  const RecentlySeenError(DioException error) : super(error: error);
}
