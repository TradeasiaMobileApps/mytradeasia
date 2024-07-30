import 'package:equatable/equatable.dart';

class CartEntity {
  final int id;
  final int cartId;
  final int userid;
  final int productId;
  final int uomId;
  final String? productName;
  final String? productImage;
  final String? hsCode;
  final String? casNumber;
  final String? incoterm;
  final String? unitName;
  final int? quantity;
  final String? pod;
  final String? note;
  bool? isChecked;

  CartEntity({
    required this.id,
    required this.cartId,
    required this.userid,
    required this.productId,
    required this.uomId,
    this.productName,
    this.productImage,
    this.hsCode,
    this.casNumber,
    this.incoterm,
    this.unitName,
    this.quantity,
    this.pod,
    this.note,
    this.isChecked = false,
  });
}
