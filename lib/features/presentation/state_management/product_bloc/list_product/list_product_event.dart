abstract class ListProductEvent {
  const ListProductEvent();
}

class GetProducts extends ListProductEvent {
  const GetProducts();
}

class DisposeProducts extends ListProductEvent {
  const DisposeProducts();
}
