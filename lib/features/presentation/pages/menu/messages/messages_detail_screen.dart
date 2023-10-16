import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/domain/entities/detail_product_entities/detail_product_entities.dart';
import 'package:mytradeasia/features/domain/usecases/detail_product_usecases/get_detail_product.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/message_collecting_handler.dart';
import 'package:mytradeasia/features/presentation/widgets/sender_bubble_chat_widget.dart';
import 'package:mytradeasia/features/presentation/widgets/user_bubble_chat_widget.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:mytradeasia/old_file_tobedeleted/widget/text_editing_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessagesDetailScreen extends StatefulWidget {
  const MessagesDetailScreen(
      {super.key,
      required this.channelUrl,
      required this.otherUserId,
      required this.currentUserId,
      required this.chatId,
      required this.prodUrl});

  final String channelUrl;
  final String chatId; // ID percakapan
  final String currentUserId; // UID pengguna saat ini
  final String otherUserId; // UID pengguna lain
  final String prodUrl;

  @override
  State<MessagesDetailScreen> createState() => MessagesDetailScreenState();
}

class MessagesDetailScreenState extends State<MessagesDetailScreen> {
  final TextEditingController _message = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();
  final GetDetailProduct _getDetailProduct = injections<GetDetailProduct>();

  MessageCollection? collection;
  String title = '';
  bool hasPrevious = false;
  bool hasNext = false;
  List<BaseMessage> messageList = [];
  List<String> memberIdList = [];
  DetailsProductEntity? product;
  GroupChannel? groupChannel;
  String url = "https://chemtradea.chemtradeasia.com/";

  @override
  void initState() {
    super.initState();
    initializeMessageCollection();
    if (widget.prodUrl != "") {
      _getProduct(widget.prodUrl);
    }
  }

  @override
  void dispose() {
    _message.dispose();
    disposeMessageCollection();
    super.dispose();
  }

  void _getProduct(String? url) async {
    var prod =
        await _getDetailProduct.call(param: url).whenComplete(() => setState(
              () {},
            ));
    product = prod.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.replace("/messages");
          },
          icon: Image.asset(
            "assets/images/icon_back.png",
            width: 24.0,
            height: 24.0,
          ),
        ),
        backgroundColor: whiteColor,
        centerTitle: false,
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: size20px),
        child: SafeArea(
          child: Column(
            children: [
              product != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: SizedBox(
                        width: size20px * 16.75,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(size20px / 2)),
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "$url${product!.detailProduct!.productimage!}",
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product!
                                                  .detailProduct!.productname!,
                                              style: heading1,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: size20px * 0.25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("CAS Number :",
                                                    style: body1Medium),
                                                Text(
                                                    product!.detailProduct!
                                                        .casNumber!,
                                                    style:
                                                        body1Regular.copyWith(
                                                            color: greyColor2)),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("HS Code :",
                                                  style: body1Medium),
                                              Text(
                                                  product!
                                                      .detailProduct!.hsCode!,
                                                  style: body1Regular.copyWith(
                                                      color: greyColor2)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _list(widget.currentUserId, "sales", _scrollController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: size20px - 7.0),
                child: Row(
                  children: [
                    Form(
                      child: Expanded(
                        child: TextEditingWidget(
                          controller: _message,
                          hintText: "Type something...",
                          readOnly: false,
                        ),
                        //     TextFormField(
                        //   decoration: InputDecoration(
                        //     hintText: "Type something...",
                        //     hintStyle: body1Regular.copyWith(color: greyColor),
                        //     enabledBorder: const OutlineInputBorder(
                        //         borderSide: BorderSide(color: greyColor),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(7.0))),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderSide: BorderSide(color: secondaryColor1),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    const SizedBox(width: size20px - 4.0),
                    Container(
                      width: size20px * 2.5,
                      height: size20px * 2.5,
                      decoration: const BoxDecoration(
                        color: secondaryColor1,
                        borderRadius: BorderRadius.all(
                          Radius.circular(size20px / 2),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // print(product);

                          if (_message.value.text.isEmpty) {
                            return;
                          }
                          collection?.channel.sendUserMessage(
                            UserMessageCreateParams(
                              message: _message.value.text,
                            ),
                            handler: (UserMessage message,
                                SendbirdException? e) async {
                              if (e != null) {
                                await showDialogToResendUserMessage(message);
                              }
                            },
                          );
                          _message.clear();
                        },
                        icon: Image.asset(
                          "assets/images/icon_send.png",
                          width: size20px,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void statusMsg(String msg) async {
    _message.text = msg;
    try {
      await groupChannel!.updateMetaData({
        'status': msg,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> showDialogToResendUserMessage(UserMessage message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text('Resend: ${message.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  collection?.channel.resendUserMessage(
                    message,
                    handler: (message, e) async {
                      if (e != null) {
                        await showDialogToResendUserMessage(message);
                      }
                    },
                  );

                  context.pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  bool isDateBeforePresent(
      DateTime messageDateTime, DateTime dayBeforeMessage) {
    if (messageDateTime.day > dayBeforeMessage.day) {
      if (messageDateTime.day > dayBeforeMessage.day &&
          messageDateTime.month > dayBeforeMessage.month) {
        if (messageDateTime.day > dayBeforeMessage.day &&
            messageDateTime.month > dayBeforeMessage.month &&
            messageDateTime.year > dayBeforeMessage.year) {
          return true;
        }
        return true;
      }
      return true;
    }
    return false;
  }

  bool isDateSameAsDateNow(DateTime messageDateTime) {
    DateTime today = DateTime.now();
    if (messageDateTime.day == today.day &&
        messageDateTime.month == today.month &&
        messageDateTime.year == today.year) {
      return false;
    } else {
      return true;
    }
  }

  DateTime toDateTime(int date) {
    return DateTime.fromMillisecondsSinceEpoch(
      date,
    );
  }

  Widget _list(
      String userId, String salesId, ItemScrollController scrollController) {
    return ScrollablePositionedList.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemScrollController: _scrollController,
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

        if (index > 0) {
          messageTime = messageList[index - 1].createdAt;
          messageDateTime = toDateTime(messageTime);
        }

        if (index == 0 && messageList.isNotEmpty) {
          messageTime = messageList[index].createdAt;
          messageDateTime = toDateTime(messageTime);
          if (isDateSameAsDateNow(toDateTime(messageList[index].createdAt))) {
            firstMessageDate =
                "${messageDateTime.day}-${messageDateTime.month}-${messageDateTime.year}";
          }
        }

        if (index > 1) {
          var dayBeforeMessage = toDateTime(messageList[index - 2].createdAt);
          if (isDateBeforePresent(messageDateTime, dayBeforeMessage)) {
            isShowSeparator = true;
            if (isDateSameAsDateNow(messageDateTime)) {
              separator =
                  "${messageDateTime.day}-${messageDateTime.month}-${messageDateTime.year}";
            }
          }
        }

        if (index == 0 && widget.currentUserId == "sales") {
          return Column(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 52, maxWidth: 100),
                height: 25,
                margin: EdgeInsets.only(bottom: 10),
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
                  message: "Hello how can i help you?",
                  state: this),
            ],
          );
        }
        if (index == 0 && widget.currentUserId != "sales") {
          return Column(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 52, maxWidth: 100),
                height: 25,
                margin: EdgeInsets.only(bottom: 10),
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
                  message: "Hello how can i help you?",
                  state: this),
            ],
          );
        }

        BaseMessage message = messageList[index - 1];
        List<Member> unreadMembers = (collection != null)
            ? collection!.channel.getUnreadMembers(message)
            : [];

        if (message.sender?.userId != userId) {
          return Column(
            children: [
              isShowSeparator
                  ? Container(
                      constraints: BoxConstraints(minWidth: 52, maxWidth: 100),
                      height: 25,
                      margin: EdgeInsets.only(bottom: 10),
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
                  : SizedBox(),
              SalesBubleChat(isFirstMessage: false, message: message.message),
            ],
          );
        }
        return Column(
          children: [
            isShowSeparator
                ? Container(
                    constraints: BoxConstraints(minWidth: 52, maxWidth: 150),
                    height: 25,
                    margin: EdgeInsets.only(bottom: 10),
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
                : SizedBox(),
            UserBubleChat(
              message: message.message,
              isSeen: unreadMembers.isNotEmpty,
              isFirstMessage: false,
            ),
          ],
        );
      },
    );
  }

  void initializeMessageCollection() async {
    groupChannel = await GroupChannel.getChannel(widget.channelUrl);
    GroupChannel.getChannel(widget.channelUrl).then((channel) async {
      collection = MessageCollection(
        channel: channel,
        params: MessageListParams(),
        handler: MessageCollectingHandler(this),
      )..initialize();

      setState(() {
        title = '${channel.name} (${messageList.length})';
        memberIdList = channel.members.map((member) => member.userId).toList();
        memberIdList.sort((a, b) => a.compareTo(b));
      });
      await Future.delayed(Duration(seconds: 1));
      _scrollController.scrollTo(
        index: collection!.messageList.length,
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
    });
  }

  void close() {
    context.pop();
  }

  void disposeMessageCollection() {
    collection?.dispose();
  }

  void refresh({bool markAsRead = false}) {
    if (markAsRead) {
      SendbirdChat.markAsRead(channelUrls: [widget.channelUrl]);
    }

    setState(() {
      if (collection != null) {
        messageList = collection!.messageList;

        title = '${collection!.channel.name} (${messageList.length})';
        hasPrevious = collection!.params.reverse
            ? collection!.hasNext
            : collection!.hasPrevious;
        hasNext = collection!.params.reverse
            ? collection!.hasPrevious
            : collection!.hasNext;
        memberIdList =
            collection!.channel.members.map((member) => member.userId).toList();
        memberIdList.sort((a, b) => a.compareTo(b));
      }
    });
  }

  void scrollToAddedMessages(CollectionEventSource eventSource) async {
    if (collection == null || collection!.messageList.length <= 1) return;

    final reverse = collection!.params.reverse;
    final previous = eventSource == CollectionEventSource.messageLoadPrevious;

    final int index;
    if ((reverse && previous) || (!reverse && !previous)) {
      index = collection!.messageList.length - 1;
    } else {
      index = 0;
    }

    while (!_scrollController.isAttached) {
      await Future.delayed(const Duration(microseconds: 1));
    }

    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }
}
