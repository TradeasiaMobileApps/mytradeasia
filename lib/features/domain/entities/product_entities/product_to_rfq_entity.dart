class ProductToRfq {
  final String productId;
  final String productName;
  final String productImage;
  final String hsCode;
  final String casNumber;
  int? quantity;
  int? uomId;
  String? unit;
  String? incoterm;
  String? pod;
  String? note;

  ProductToRfq(
      {required this.productId,
      required this.productName,
      required this.productImage,
      required this.hsCode,
      required this.casNumber,
      this.quantity,
      this.uomId,
      this.unit,
      this.incoterm,
      this.pod,
      this.note});
}
