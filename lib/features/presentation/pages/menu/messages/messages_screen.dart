import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_event.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_state.dart';
import 'package:mytradeasia/features/presentation/widgets/channel_widgets/channel_list.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen>
    with GroupChannelCollectionHandler {
  late GroupChannelCollection collection;
  late ChannelListBloc channelBloc;

  String title = 'GroupChannels';
  bool hasMore = false;

  // LIST<MEMBER> Length is EXACTLY 2
  String lookForOtherUser(
      {required String currentUserId, required List<Member> listMember}) {
    if (listMember.length != 2) {
      return "Invalid channel";
    }
    return listMember
        .firstWhere((element) => element.userId != currentUserId)
        .userId;
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    channelBloc = BlocProvider.of<ChannelListBloc>(context);
    collection = GroupChannelCollection(
      query: GroupChannelListQuery()
        ..order = GroupChannelListQueryOrder.latestLastMessage,
      handler: this,
    )..loadMore();
  }

  @override
  void dispose() {
    collection.dispose();
    super.dispose();
  }

  @override
  void onChannelsAdded(
      GroupChannelContext context, List<GroupChannel> channels) {
    channelBloc.add(RefreshChannels(channels));
  }

  @override
  void onChannelsDeleted(
      GroupChannelContext context, List<String> deletedChannelUrls) {
    channelBloc.add(RefreshChannels(collection.channelList));
  }

  @override
  void onChannelsUpdated(
      GroupChannelContext context, List<GroupChannel> channels) {
    channelBloc.add(RefreshChannels(channels));
  }

  void searchMessage(String query) {
    if (query.length == 3 || query.isEmpty) {
      channelBloc.add(SearchChannels(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    // const int index = 2;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: size20px),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: size20px),
                  child: Text(
                    "Messages",
                    style: heading2,
                  ),
                ),
                SizedBox(
                  height: size20px + 30,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 15.0),
                          child: Image.asset(
                            "assets/images/icon_search.png",
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                        hintText: "What do you want to search?",
                        hintStyle: body1Regular.copyWith(color: greyColor),
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor1),
                        ),
                      ),
                      onChanged: (value) {
                        searchMessage(value);
                      },
                    ),
                  ),
                ),
                BlocBuilder<ChannelListBloc, ChannelListState>(
                  bloc: channelBloc,
                  builder: (context, state) {
                    if (state is ChannelListSuccess) {
                      var totalUnreadCount = state.channelList!.isNotEmpty
                          ? state.channelList!
                              .map((e) => e.unreadMessageCount)
                              .reduce((n1, n2) => n1 + n2)
                          : 0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: size20px),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                for (var e in state.channelList!) {
                                  e.clearUnreadCount();
                                }
                              });
                            },
                            child: Text(
                              totalUnreadCount != 0
                                  ? "Read All($totalUnreadCount)"
                                  : "Read All(0)",
                              style:
                                  body1Regular.copyWith(color: secondaryColor1),
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: size20px),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              for (var e in state.channelList!) {
                                e.clearUnreadCount();
                              }
                            });
                          },
                          child: Text(
                            "Read All(0)",
                            style:
                                body1Regular.copyWith(color: secondaryColor1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ChannelListWidget(channelListBloc: channelBloc),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
      //   builder: (context, state) {
      //     return FloatingActionButton(
      //       backgroundColor: secondaryColor1,
      //       onPressed: () async {
      //         await GroupChannel.createChannel(GroupChannelCreateParams()
      //               ..name = state.sendbirdUser!.nickname
      //               ..userIds = [state.sendbirdUser!.userId, 'sales'])
      //             .then((groupChannel) {
      //           context.goNamed("message",
      //               extra: MessageDetailParameter(
      //                 otherUserId: "sales",
      //                 currentUserId: state.sendbirdUser!.userId,
      //                 chatId: groupChannel.chat.chatId.toString(),
      //                 channelUrl: groupChannel.channelUrl,
      //               ));
      //         });
      //       },
      //       child: const Icon(Icons.add),
      //     );
      //   },
      // ),
    );
  }
}
