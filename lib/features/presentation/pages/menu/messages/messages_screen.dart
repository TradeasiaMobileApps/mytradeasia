import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_collecting_handler.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  late GroupChannelCollection collection;

  String title = 'GroupChannels';
  bool hasMore = false;
  List<GroupChannel> channelList = [];
  List<GroupChannel> channelSaved = [];

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
    collection = GroupChannelCollection(
      query: GroupChannelListQuery()
        ..order = GroupChannelListQueryOrder.latestLastMessage,
      handler: ChannelCollectionHandler(this),
    )..loadMore();
  }

  @override
  void dispose() {
    collection.dispose();
    super.dispose();
  }

  String messageDateTime(GroupChannel groupChannel) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateFormat formatter = DateFormat('HH:mm');
    var messageDateTime = DateTime.fromMillisecondsSinceEpoch(
      groupChannel.lastMessage?.createdAt ?? 0,
    );
    var todayDatetime = DateTime.now();

    //return todays time if there are no last message
    if (formatter.format(messageDateTime).toString() == "07:00") {
      return formatter.format(todayDatetime);
    }

    //return date if last message was further than yesterday
    if (todayDatetime.year - messageDateTime.year > 0) {
      return dateFormat.format(messageDateTime);
    }

    if (todayDatetime.month - messageDateTime.month > 0) {
      return dateFormat.format(messageDateTime);
    }
    if (todayDatetime.day - messageDateTime.day > 1 &&
        todayDatetime.month - messageDateTime.month == 0) {
      return dateFormat.format(messageDateTime);
    }

    //return yesterday if last message was the day before today
    if (todayDatetime.day - messageDateTime.day == 1) {
      return "yesterday";
    }

    //return time with format HH:mm of present day
    return formatter.format(messageDateTime);
  }

  void searchMessage(String query) {
    channelList = channelSaved.where((gc) {
      final channelName = gc.name.toLowerCase();
      final input = query.toLowerCase();

      return channelName.contains(input);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // const int index = 2;
    var totalUnreadCount = channelList.isNotEmpty
        ? channelList
            .map((e) => e.unreadMessageCount)
            .reduce((n1, n2) => n1 + n2)
        : 0;
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: size20px),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        channelList.forEach((e) {
                          e.clearUnreadCount();
                        });
                        setState(() {});
                      },
                      child: Text(
                        totalUnreadCount != 0
                            ? "Read All($totalUnreadCount)"
                            : "Read All(0)",
                        style: body1Regular.copyWith(color: secondaryColor1),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, userState) {
                  if (channelList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No conversation yet",
                        style: text18,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: channelList.isEmpty ? 0 : channelList.length,
                      itemBuilder: (context, index) {
                        final groupChannel = channelList[index];

                        // final sender = groupChannel.members.firstWhere(
                        //     (element) =>
                        //         element.userId !=
                        //         userState.sendbirdUser!.userId);
                        final dateTime = messageDateTime(groupChannel);

                        return InkWell(
                          onTap: () async {
                            // print(userState.sendbirdUser!.nickname);
                            context.goNamed("message",
                                extra: MessageDetailParameter(
                                  otherUserId: "sales",
                                  currentUserId: userState.sendbirdUser!.userId,
                                  customerName:
                                      userState.sendbirdUser!.nickname,
                                  chatId: groupChannel.chat.chatId.toString(),
                                  channelUrl: groupChannel.channelUrl,
                                  prodUrl: groupChannel.data,
                                ));

                            // print(await state.channels![index]
                            //     .getMessagesByTimestamp(
                            //         DateTime.now().millisecondsSinceEpoch *
                            //             1000,
                            //         MessageListParams()));

                            /* With go_router */
                            // MessageDetailParameter param =
                            // MessageDetailParameter(
                            //     otherUserId: otherUser,
                            //     currentUserId: _currentUser,
                            //     chatId: chatId.toString());
                            //
                            // context.goNamed("message", extra: param);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      FutureBuilder(
                                        future: groupChannel.getAllMetaData(),
                                        builder: (context, snapshot) {
                                          String image =
                                              "assets/images/icon_complaint.png";

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          size20px * 5)),
                                              child: Image.asset(
                                                "assets/images/icon_complaint.png",
                                                height: size20px + 24.0,
                                                width: size20px + 24.0,
                                              ),
                                            );
                                          } else {
                                            switch (snapshot.data!["status"]) {
                                              case "Product":
                                                image =
                                                    "assets/images/icon_products_message.png";
                                                break;
                                              case "Sample":
                                                image =
                                                    "assets/images/icon_sample.png";
                                                break;
                                              case "MOQ":
                                                image =
                                                    "assets/images/icon_moq.png";
                                                break;
                                              case "Price":
                                                image =
                                                    "assets/images/icon_price.png";
                                                break;
                                              case "Payment":
                                                image =
                                                    "assets/images/icon_payment.png";
                                                break;
                                              default:
                                                image =
                                                    "assets/images/icon_complaint.png";
                                            }

                                            return ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          size20px * 5)),
                                              child: Image.asset(
                                                image,
                                                height: size20px + 24.0,
                                                width: size20px + 24.0,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      // ClipRRect(
                                      //   borderRadius: const BorderRadius.all(
                                      //       Radius.circular(size20px * 5)),
                                      //   child: Image.asset(
                                      //     "assets/images/profile_picture.png",
                                      //     height: size20px + 34.0,
                                      //     width: size20px + 34.0,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: size20px),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: AutoSizeText(
                                                // ASSUMPTIONS : ONLY 2 Member inside the Group Channel
                                                //TODO:change this
                                                groupChannel.name.length > 17
                                                    ? "${groupChannel.name.substring(0, 17)} ..."
                                                    : groupChannel.name,
                                                style: heading3.copyWith(
                                                  color: blackColor,
                                                ),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Flexible(
                                              flex: 4,
                                              child: FutureBuilder<
                                                  Map<String, String>>(
                                                future: groupChannel
                                                    .getAllMetaData(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SizedBox();
                                                  } else {
                                                    if (snapshot
                                                            .data!["status"] !=
                                                        null) {
                                                      return Container(
                                                        height: 18,
                                                        width: 50,
                                                        margin: const EdgeInsets
                                                            .only(left: 10),
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                99,
                                                                49,
                                                                200,
                                                                180),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Center(
                                                          child: Text(
                                                            snapshot.data?[
                                                                    "status"] ??
                                                                "",
                                                            style:
                                                                text8.copyWith(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: size20px / 4),
                                        Text(
                                          groupChannel.lastMessage?.message ??
                                              "",
                                          style: text10.copyWith(
                                              color: greyColor2),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(width: size20px),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          dateTime,
                                          style: text10.copyWith(
                                              color: greyColor2),
                                        ),
                                        const SizedBox(height: size20px / 4),
                                        groupChannel.unreadMessageCount != 0
                                            ? CircleAvatar(
                                                maxRadius: 12,
                                                backgroundColor:
                                                    secondaryColor1,
                                                child: Text(
                                                  groupChannel
                                                      .unreadMessageCount
                                                      .toString(),
                                                  style: body1Regular.copyWith(
                                                      color: whiteColor),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
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

  void refresh() {
    setState(() {
      channelList = collection.channelList;
      channelSaved = channelList;
    });
  }
}
