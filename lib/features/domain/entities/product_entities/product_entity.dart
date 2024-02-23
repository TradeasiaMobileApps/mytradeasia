import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? productId;
  final String? productname;
  final String? productimage;
  final String? hsCode;
  final String? casNumber;

  const ProductEntity({
    this.productId,
    this.productname,
    this.productimage,
    this.hsCode,
    this.casNumber,
  });

  @override
  List<Object?> get props {
    return [
      productId,
      productname,
      productimage,
      hsCode,
      casNumber,
    ];
  }
}
