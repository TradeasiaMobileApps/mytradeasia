import 'package:mytradeasia/features/domain/entities/cart_entities/cart_entities.dart';

class CartModel extends CartEntity {
  CartModel({
    required int id,
    required int cartId,
    required int userId,
    required int uomId,
    required int productId,
    String? productName,
    String? unitName,
    String? incoterm,
    int? quantity,
    String? productImage,
    String? hsCode,
    String? casNumber,
    String? pod,
    String? note,
  }) : super(
          id: id,
          cartId: cartId,
          userid: userId,
          uomId: uomId,
          productId: productId,
          productName: productName,
          unitName: unitName,
          incoterm: incoterm,
          quantity: quantity,
          productImage: productImage,
          hsCode: hsCode,
          casNumber: casNumber,
          pod: pod,
          note: note,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      cartId: json['cart_id'],
      userId: json['user_id'],
      uomId: json['uom_id'],
      productId: json['product_id'],
      productName: json['product_detail']['productname'],
      productImage: json['product_detail']['productimage'],
      unitName: json['uom_detail']['uom_name'],
      incoterm: json['incoterm'],
      quantity: json['qty'],
      hsCode: json['product_detail']['hs_code'],
      casNumber: json['product_detail']['cas_number'],
      pod: json['pod'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartitem_id'] = id;
    data['product_id'] = productId;
    data['uom_id'] = uomId;
    data['qty'] = quantity;
    data['incoterm'] = incoterm;
    data['pod'] = pod;
    data['note'] = note;
    return data;
  }
}
