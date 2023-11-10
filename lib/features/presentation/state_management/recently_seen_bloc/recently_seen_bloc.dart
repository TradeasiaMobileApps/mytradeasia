import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/delete_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_recently_seen.dart';

// import 'recently_seen_event.dart';
import '../../../domain/usecases/user_usecases/add_recently_seen.dart';
import 'recently_seen_event.dart';
import 'recently_seen_state.dart';

class RecentlySeenBloc extends Bloc<RecentlySeenEvent, RecentlySeenState> {
  final AddRecentlySeen _addRecentlySeen;
  final GetRecentlySeen _getRecentlySeen;
  final DeleteRecentlySeen _deleteRecentlySeen;

  RecentlySeenBloc(
      this._addRecentlySeen, this._getRecentlySeen, this._deleteRecentlySeen)
      : super(const RecentlySeenInit()) {
    on<AddRecentlySeenEvent>((event, emit) {
      Map<String, dynamic> data = {
        "productName": event.recentlySeen.productname,
        "seo_url": event.recentlySeen.seoUrl,
        "casNumber": event.recentlySeen.casNumber,
        "hsCode": event.recentlySeen.hsCode,
        "productImage": event.recentlySeen.productimage,
      };

      _addRecentlySeen.call(param: data);
    });
    on<GetRecentlySeenEvent>((event, emit) async {
      var recentSeen = await _getRecentlySeen.call();
      emit(RecentlySeenDone(recentSeen));
    });

    on<DeleteRecentlySeenEvent>((event, emit) {
      _deleteRecentlySeen.call();
      emit(const RecentlySeenDone([]));
    });
  }
}
