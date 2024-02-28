import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int? productId;
  final String? productName;
  final String? productImage;
  final String? hsCode;
  final String? casNumber;
  final String? seoUrl;
  final String? unit;
  final double? quantity;

  const CartEntity(
      {this.productId,
      this.productName,
      this.productImage,
      this.hsCode,
      this.casNumber,
      this.seoUrl,
      this.unit,
      this.quantity});

  @override
  List<Object?> get props {
    return [
      productId,
      productName,
      productImage,
      hsCode,
      casNumber,
      seoUrl,
      unit,
      quantity
    ];
  }
}
