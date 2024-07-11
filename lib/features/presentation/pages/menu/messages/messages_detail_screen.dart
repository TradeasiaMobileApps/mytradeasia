import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';
import 'package:mytradeasia/features/domain/entities/detail_product_entities/detail_product_entities.dart';
import 'package:mytradeasia/features/domain/usecases/detail_product_usecases/get_detail_product.dart';
import 'package:mytradeasia/features/presentation/state_management/chat_handler/message_collecting_handler.dart';
import 'package:mytradeasia/features/presentation/widgets/chat_widgets/chat_list.dart';
import 'package:mytradeasia/features/presentation/widgets/text_editing_widget.dart';
import 'package:mytradeasia/helper/injections_container.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MessagesDetailScreen extends StatefulWidget {
  const MessagesDetailScreen(
      {super.key,
      required this.channelUrl,
      required this.otherUserId,
      required this.currentUserId,
      required this.chatId,
      required this.productId,
      required this.customerName});

  final String channelUrl;
  final String chatId; // ID percakapan
  final String currentUserId; // UID pengguna saat ini
  final String otherUserId; // UID pengguna lain
  final String productId;
  final String customerName;

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
  // String url = "https://chemtradea.chemtradeasia.com/";

  @override
  void initState() {
    super.initState();
    initializeMessageCollection();

    _getProduct(int.parse(widget.productId));
  }

  @override
  void dispose() {
    _message.dispose();
    disposeMessageCollection();
    super.dispose();
  }

  void _getProduct(int? productId) async {
    var prod = await _getDetailProduct
        .call(param: productId)
        .whenComplete(() => setState(
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
                                          imageUrl: product!
                                              .detailProduct!.productimage!,
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
                // child: _list(widget.currentUserId, "sales", _scrollController),
                child: ChatList(
                  currentUserId: widget.currentUserId,
                  scrollController: _scrollController,
                  messageList: messageList,
                  collection: collection,
                  state: this,
                  customerName: widget.customerName,
                ),
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
                          autofocus: true,
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

  void statusMsg(String status, String msg) async {
    _message.text = msg;
    try {
      await groupChannel!.updateMetaData({
        'status': status,
      });
    } catch (e) {
      log(e.toString());
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
      await Future.delayed(const Duration(seconds: 1));
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
