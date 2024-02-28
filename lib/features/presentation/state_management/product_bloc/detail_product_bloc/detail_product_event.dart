abstract class DetailProductEvent {
  const DetailProductEvent();
}

class GetDetailProductEvent extends DetailProductEvent {
  final int productId;
  const GetDetailProductEvent(this.productId);
}

class DetailDispose extends DetailProductEvent {}
