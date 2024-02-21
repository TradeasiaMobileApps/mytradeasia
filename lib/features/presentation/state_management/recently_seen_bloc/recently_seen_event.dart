import '../../../domain/entities/all_product_entities/all_product_entity.dart';

abstract class RecentlySeenEvent {
  const RecentlySeenEvent();
}

class GetRecentlySeenEvent extends RecentlySeenEvent {
  const GetRecentlySeenEvent();
}

class AddRecentlySeenEvent extends RecentlySeenEvent {
  final AllProductEntities recentlySeen;

  const AddRecentlySeenEvent(this.recentlySeen);
}

class DeleteRecentlySeenEvent extends RecentlySeenEvent {
  const DeleteRecentlySeenEvent();
}
