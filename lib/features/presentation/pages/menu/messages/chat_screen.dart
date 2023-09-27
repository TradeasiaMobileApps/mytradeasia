import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class ChatScreen extends StatefulWidget {
  final String appId;
  final String userId;
  final List<String> otherUserIds;
  const ChatScreen(
      {Key? key,
      required this.appId,
      required this.userId,
      required this.otherUserIds})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with BaseChannelHandler {
  List<BaseMessage> _messages = [];
  GroupChannel? _channel;

  @override
  void initState() {
    load();
    SendbirdChat.addChannelHandler("chat", this);
    super.initState();
  }

  @override
  void dispose() {
    SendbirdChat.removeChannelHandler("chat");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen"),
      ),
      body: DashChat(
          currentUser: asDashChatUser(SendbirdChat.currentUser),
          onSend: (newMessage) {
            log(_messages.toString());
          },
          messages: asDashChatMessages(_messages)),
    );
  }

  ChatUser asDashChatUser(User? user) {
    if (user == null) {
      return ChatUser(id: "", profileImage: "", firstName: "", lastName: "");
    }
    return ChatUser(
        id: user.userId,
        firstName: user.nickname,
        lastName: "",
        profileImage: user.profileUrl);
  }

  List<ChatMessage> asDashChatMessages(List<BaseMessage> messages) {
    return [
      for (BaseMessage sbm in messages)
        ChatMessage(
            user: asDashChatUser(sbm.sender),
            createdAt: DateTime.fromMillisecondsSinceEpoch(sbm.createdAt),
            text: sbm.message)
    ];
  }

  void load() async {
    try {
      //  init + connect
      final _ = SendbirdChat.connect(widget.userId);

      // get existing channel
      final query = GroupChannelListQuery()
        ..limit = 1
        ..userIdsExactFilter = widget.otherUserIds;
      List<GroupChannel> channels = await query.next();
      GroupChannel aChannel;
      if (channels.isEmpty) {
        // create new channel
        aChannel = await GroupChannel.createChannel(GroupChannelCreateParams()
          ..userIds = widget.otherUserIds + [widget.userId]);
      } else {
        aChannel = channels[0];
      }

      // get messages from channel
      List<BaseMessage> messages = await aChannel.getMessagesByTimestamp(
          DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());

      // set data
      setState(() {
        _messages = messages;
        _channel = aChannel;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    setState(() {
      _messages.add(message);
    });
  }
}
