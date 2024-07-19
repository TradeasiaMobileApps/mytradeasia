class AddCartEntities {
  final int productId;
  final int uomId;
  final int qty;
  final String incoterm;
  final String pod;
  final String? note;

  const AddCartEntities(
      {required this.productId,
      required this.uomId,
      required this.qty,
      required this.incoterm,
      required this.pod,
      this.note});
}
