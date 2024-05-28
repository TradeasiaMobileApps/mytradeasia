import 'package:flutter/material.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/presentation/pages/menu/messages/messages_detail_screen.dart';
import 'package:mytradeasia/features/presentation/widgets/sender_bubble_chat_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/user_bubble_chat_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.currentUserId,
    required this.scrollController,
    required this.messageList,
    this.collection,
    required this.state,
    required this.customerName,
  });

  final String currentUserId;

  final ItemScrollController scrollController;
  final List<BaseMessage> messageList;
  final MessageCollection? collection;
  final MessagesDetailScreenState state;
  final String customerName;

  // bool isDateBeforePresent(
  //     DateTime messageDateTime, DateTime dayBeforeMessage) {
  //   if (messageDateTime.day > dayBeforeMessage.day) {
  //     if (messageDateTime.day > dayBeforeMessage.day &&
  //         messageDateTime.month > dayBeforeMessage.month) {
  //       if (messageDateTime.day > dayBeforeMessage.day &&
  //           messageDateTime.month > dayBeforeMessage.month &&
  //           messageDateTime.year > dayBeforeMessage.year) {
  //         return true;
  //       }
  //       return true;
  //     }
  //     return true;
  //   }
  //   return false;
  // }

  ///check if date is before today
  bool isDateBeforePresent(
      DateTime messageDateTime, DateTime dayBeforeMessage) {
    return messageDateTime.year > dayBeforeMessage.year ||
        (messageDateTime.year == dayBeforeMessage.year &&
            messageDateTime.month > dayBeforeMessage.month) ||
        (messageDateTime.year == dayBeforeMessage.year &&
            messageDateTime.month == dayBeforeMessage.month &&
            messageDateTime.day > dayBeforeMessage.day);
  }

  ///Check if date same as today
  bool isDateSameAsDateNow(DateTime messageDateTime) {
    DateTime today = DateTime.now();
    if (messageDateTime.day == today.day &&
        messageDateTime.month == today.month &&
        messageDateTime.year == today.year) {
      return true;
    } else {
      return false;
    }
  }

  ///convert raw time to DateTime data type
  DateTime toDateTime(int date) {
    return DateTime.fromMillisecondsSinceEpoch(
      date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemScrollController: scrollController,
      itemCount: 1 + messageList.length,
      initialScrollIndex: (collection != null && collection!.params.reverse)
          ? 0
          : messageList.length,
      itemBuilder: (context, index) {
        int messageTime = 0;
        DateTime messageDateTime = DateTime.fromMillisecondsSinceEpoch(
          messageTime,
        );
        String separator = "Today";
        String firstMessageDate = "Today";
        bool isShowSeparator = false;

        ///this if condition is to save current index message time after the template message
        if (index > 0) {
          messageTime = messageList[index - 1].createdAt;
          messageDateTime = toDateTime(messageTime);
        }

        ///this if condition is to check if first message is from today
        ///if first message is from today then the separator will shown 'Today'
        ///if the first message is not today then it will shown as date
        if (index == 0 && messageList.isNotEmpty) {
          messageTime = messageList[index].createdAt;
          messageDateTime = toDateTime(messageTime);
          if (!isDateSameAsDateNow(toDateTime(messageList[index].createdAt))) {
            firstMessageDate =
                "${messageDateTime.day}-${messageDateTime.month}-${messageDateTime.year}";
          }
        }

        ///this logic is to check every message time, to separate message based on the date they sent
        ///how this works is the program check `messageList[index-1]` time with `messageList[index - 2]`
        ///the first if condition is to check if the message is not the first message
        if (index > 1) {
          ///the dayBeforeMessage variable is to get message date time before the newest message
          var dayBeforeMessage = toDateTime(messageList[index - 2].createdAt);

          ///this if condition is to check current index message with previous of current index message
          if (isDateBeforePresent(messageDateTime, dayBeforeMessage)) {
            isShowSeparator = true;

            ///this is to check if the current index message
            if (!isDateSameAsDateNow(messageDateTime)) {
              separator =
                  "${messageDateTime.day}-${messageDateTime.month}-${messageDateTime.year}";
            }
          }
        }

        if (index == 0 && currentUserId == "sales") {
          return UserBubleChat(
            message: "Hello $customerName, what do you want to ask?",
            isSeen: true,
          );
        }
        if (index == 0 && currentUserId != "sales") {
          return Column(
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 52, maxWidth: 100),
                height: 25,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: secondaryColor1,
                ),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        firstMessageDate,
                        style: body1Regular.copyWith(color: whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
              SalesBubleChat(
                  isFirstMessage: true,
                  message: "Hello $customerName, what do you want to ask?",
                  state: state),
            ],
          );
        }

        BaseMessage message = messageList[index - 1];

        List<Member> unreadMembers = (collection != null)
            ? collection!.channel.getUnreadMembers(message)
            : [];

        if (message.sender?.userId != currentUserId) {
          return Column(
            children: [
              isShowSeparator
                  ? Container(
                      constraints:
                          const BoxConstraints(minWidth: 52, maxWidth: 100),
                      height: 25,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: secondaryColor1,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Text(
                              separator,
                              style: body1Regular.copyWith(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              SalesBubleChat(isFirstMessage: false, message: message.message),
            ],
          );
        }

        return Column(
          children: [
            isShowSeparator
                ? Container(
                    constraints:
                        const BoxConstraints(minWidth: 52, maxWidth: 150),
                    height: 25,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondaryColor1,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            separator,
                            style: body1Regular.copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            UserBubleChat(
              message: message.message,
              isSeen: unreadMembers.isNotEmpty,
            ),
          ],
        );
      },
    );
  }
}
