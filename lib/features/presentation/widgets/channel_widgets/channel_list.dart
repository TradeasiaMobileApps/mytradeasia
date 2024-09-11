import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mytradeasia/config/routes/parameters.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/channel_list_bloc.dart/channel_list_state.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';


///TODO: DONT DELETE THIS, theres a problem with sendbird chat sdk package
// class ChannelListWidget extends StatelessWidget {
//   const ChannelListWidget({super.key, required this.channelListBloc});

//   final ChannelListBloc channelListBloc;

//   String messageDateTime(GroupChannel groupChannel) {
//     final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
//     final DateFormat formatter = DateFormat('HH:mm');
//     var messageDateTime = DateTime.fromMillisecondsSinceEpoch(
//       groupChannel.lastMessage?.createdAt ?? 0,
//     );
//     var todayDatetime = DateTime.now();

//     //return todays time if there are no last message
//     if (formatter.format(messageDateTime).toString() == "07:00") {
//       return formatter.format(todayDatetime);
//     }

//     //return date if last message was further than yesterday
//     if (todayDatetime.year - messageDateTime.year > 0) {
//       return dateFormat.format(messageDateTime);
//     }

//     if (todayDatetime.month - messageDateTime.month > 0) {
//       return dateFormat.format(messageDateTime);
//     }
//     if (todayDatetime.day - messageDateTime.day > 1 &&
//         todayDatetime.month - messageDateTime.month == 0) {
//       return dateFormat.format(messageDateTime);
//     }

//     //return yesterday if last message was the day before today
//     if (todayDatetime.day - messageDateTime.day == 1) {
//       return "yesterday";
//     }

//     //return time with format HH:mm of present day
//     return formatter.format(messageDateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(builder: (context, userState) {
//       return BlocBuilder<ChannelListBloc, ChannelListState>(
//         bloc: channelListBloc,
//         builder: (context, state) {
//           if (state is ChannelListLoading) {
//             return const CircularProgressIndicator.adaptive(
//               backgroundColor: primaryColor1,
//             );
//           }

//           if (state.channelList!.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No conversation yet",
//                 style: text18,
//               ),
//             );
//           } else {
//             return ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount:
//                   state.channelList!.isEmpty ? 0 : state.channelList!.length,
//               itemBuilder: (context, index) {
//                 final groupChannel = state.channelList![index];

//                 final dateTime = messageDateTime(groupChannel);

//                 return InkWell(
//                   onTap: () async {
//                     groupChannel.getMetaData(["productId"]).then(
//                       (value) => context.goNamed("message",
//                           extra: MessageDetailParameter(
//                             otherUserId: "sales",
//                             currentUserId: userState.sendbirdUser!.userId,
//                             customerName: userState.sendbirdUser!.nickname,
//                             chatId: groupChannel.chat.chatId.toString(),
//                             channelUrl: groupChannel.channelUrl,
//                             productId: value["productId"]!,
//                           )),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 7.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Stack(
//                             children: [
//                               FutureBuilder(
//                                 future: groupChannel.getAllMetaData(),
//                                 builder: (context, snapshot) {
//                                   String image =
//                                       "assets/images/icon_complaint.png";

//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return ClipRRect(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(size20px * 5)),
//                                       child: Image.asset(
//                                         "assets/images/icon_complaint.png",
//                                         height: size20px + 24.0,
//                                         width: size20px + 24.0,
//                                       ),
//                                     );
//                                   } else {
//                                     switch (snapshot.data!["status"]) {
//                                       case "Product":
//                                         image =
//                                             "assets/images/icon_products_message.png";
//                                         break;
//                                       case "Sample":
//                                         image = "assets/images/icon_sample.png";
//                                         break;
//                                       case "MOQ":
//                                         image = "assets/images/icon_moq.png";
//                                         break;
//                                       case "Price":
//                                         image = "assets/images/icon_price.png";
//                                         break;
//                                       case "Payment":
//                                         image =
//                                             "assets/images/icon_payment.png";
//                                         break;
//                                       default:
//                                         image =
//                                             "assets/images/icon_complaint.png";
//                                     }

//                                     return ClipRRect(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(size20px * 5)),
//                                       child: Image.asset(
//                                         image,
//                                         height: size20px + 24.0,
//                                         width: size20px + 24.0,
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                               // ClipRRect(
//                               //   borderRadius: const BorderRadius.all(
//                               //       Radius.circular(size20px * 5)),
//                               //   child: Image.asset(
//                               //     "assets/images/profile_picture.png",
//                               //     height: size20px + 34.0,
//                               //     width: size20px + 34.0,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           const SizedBox(width: size20px),
//                           Expanded(
//                             flex: 3,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 7,
//                                       child: AutoSizeText(
//                                         // ASSUMPTIONS : ONLY 2 Member inside the Group Channel
//                                         //TODO:change this
//                                         groupChannel.name.length > 17
//                                             ? "${groupChannel.name.substring(0, 17)} ..."
//                                             : groupChannel.name,
//                                         style: heading3.copyWith(
//                                           color: blackColor,
//                                         ),
//                                         minFontSize: 10,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     Flexible(
//                                       flex: 4,
//                                       child: FutureBuilder<Map<String, String>>(
//                                         future: groupChannel.getAllMetaData(),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return const SizedBox();
//                                           } else {
//                                             if (snapshot.data!["status"] !=
//                                                 null) {
//                                               return Container(
//                                                 height: 18,
//                                                 width: 50,
//                                                 margin: const EdgeInsets.only(
//                                                     left: 10),
//                                                 decoration: BoxDecoration(
//                                                     color: const Color.fromARGB(
//                                                         224, 243, 247, 250),
//                                                     border: Border.all(
//                                                       color:
//                                                           const Color.fromARGB(
//                                                               160, 18, 60, 105),
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20)),
//                                                 child: Center(
//                                                   child: Text(
//                                                     snapshot.data?["status"] ??
//                                                         "",
//                                                     style: text10.copyWith(
//                                                       fontSize: 9,
//                                                       color:
//                                                           const Color.fromARGB(
//                                                               160, 18, 60, 105),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             } else {
//                                               return Container();
//                                             }
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: size20px / 4),
//                                 Text(
//                                   groupChannel.lastMessage?.message ?? "",
//                                   style: text10.copyWith(color: greyColor2),
//                                   maxLines: 2,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // const SizedBox(width: size20px),
//                           Flexible(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   dateTime,
//                                   style: text10.copyWith(color: greyColor2),
//                                 ),
//                                 const SizedBox(height: size20px / 4),
//                                 groupChannel.unreadMessageCount != 0
//                                     ? CircleAvatar(
//                                         maxRadius: 12,
//                                         backgroundColor: secondaryColor1,
//                                         child: Text(
//                                           groupChannel.unreadMessageCount
//                                               .toString(),
//                                           style: body1Regular.copyWith(
//                                               color: whiteColor),
//                                         ),
//                                       )
//                                     : Container()
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       );
//     });
//   }
// }
