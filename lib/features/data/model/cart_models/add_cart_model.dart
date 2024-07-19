import 'package:mytradeasia/features/domain/entities/cart_entities/add_cart_entities.dart';

class AddCartModel extends AddCartEntities {
  const AddCartModel({
    required int productId,
    required int uomId,
    required int qty,
    required String incoterm,
    required String pod,
    String? note,
  }) : super(
            productId: productId,
            uomId: uomId,
            qty: qty,
            incoterm: incoterm,
            pod: pod,
            note: note);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['uom_id'] = uomId;
    data['qty'] = qty;
    data['incoterm'] = incoterm;
    data['pod'] = pod;
    data['note'] = note;
    return data;
  }
}
