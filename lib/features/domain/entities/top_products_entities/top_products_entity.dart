import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';

class TopProductEntity extends ProductEntity {
  const TopProductEntity({
    int? productId,
    String? productimage,
    String? productname,
    String? casNumber,
    String? hsCode,
  }) : super(
          productId: productId,
          productname: productname,
          productimage: productimage,
          hsCode: hsCode,
          casNumber: casNumber,
        );

  @override
  List<Object?> get props {
    return [productId, productimage, productname, casNumber, hsCode];
  }
}
