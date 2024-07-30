class ProductToRfq {
  final String productId;
  final String productName;
  final String productImage;
  final String hsCode;
  final String casNumber;
  int? quantity;
  String? unit;

  ProductToRfq(
      {required this.productId,
      required this.productName,
      required this.productImage,
      required this.hsCode,
      required this.casNumber,
      this.quantity,
      this.unit});
}
