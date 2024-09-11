// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_event.dart';
// import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_state.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

// class ChannelListBloc extends Bloc<ChannelListEvent, ChannelListState> {
//   ChannelListBloc() : super(const ChannelListLoading()) {
//     on<GetChannels>(onGetChannels);
//     on<RefreshChannels>(onRefreshChannels);
//     on<SearchChannels>(onSearchChannels);
//   }

//   FutureOr<void> onGetChannels(
//       GetChannels event, Emitter<ChannelListState> emit) {
//     var collection = GroupChannelCollection(
//       query: GroupChannelListQuery()
//         ..order = GroupChannelListQueryOrder.latestLastMessage,
//       handler: event.handler,
//     )..loadMore();
//     emit(ChannelListSuccess(collection.channelList));
//   }

//   FutureOr<void> onRefreshChannels(
//       RefreshChannels event, Emitter<ChannelListState> emit) {
//     emit(ChannelListSuccess(event.collection));
//   }

//   FutureOr<void> onSearchChannels(
//       SearchChannels event, Emitter<ChannelListState> emit) async {
//     try {
//       final query = GroupChannelListQuery()
//         ..channelNameContainsFilter = event.query.toLowerCase();

//       final groupChannels = await query.next();

//       emit(ChannelListSuccess(groupChannels));
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
