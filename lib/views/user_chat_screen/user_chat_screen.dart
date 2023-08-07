import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:echospace/models/chat_model.dart';
import 'package:echospace/models/user_model.dart';
import 'package:echospace/services/push_notification.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/utils/functions/alert.dart';
import 'package:echospace/utils/functions/pick_and_crop_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserChat extends StatefulWidget {
  const UserChat({
    super.key,
    required this.senderMobile,
    required this.receiver,
  });
  final String senderMobile;
  final UserModel receiver;

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  bool _showEmoji = false;

  final TextEditingController _messageController = TextEditingController();

  late String? id;

  Future<void> sendMessage(String message, String id, Type type) async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
        .collection('messages');
    _messageController.clear();

    final chatModel = Chat(
        text: message,
        sender: widget.senderMobile,
        receiver: widget.receiver.mobile,
        type: type,
        timestamp: Timestamp.now());

    await collection.add(chatModel.toJson()).then((value) =>
        FCM.sendPushNotification(widget.receiver.fcmToken,
            widget.receiver.name.toUpperCase(), message));
  }

  @override
  Widget build(BuildContext context) {
    id = convId(widget.senderMobile, widget.receiver.mobile);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_showEmoji) {
            setState(() => _showEmoji = !_showEmoji);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: kBgBlack,
          appBar: AppBar(
            backgroundColor: kBgBlack,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: kWhite,
                )),
            title: Text(
              widget.receiver.userName,
              style: const TextStyle(color: kWhite),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(id)
                      .collection('messages')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kRed,
                        ),
                      );
                    }

                    final List<Chat> chats = snapshot.data!.docs
                        .map((e) => Chat.fromJson(e.data()))
                        .toList();

                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Message Yet.',
                          style: TextStyle(color: kWhite, fontSize: 20),
                        ),
                      );
                    }

                    return ListView.separated(
                      reverse: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              chats[index].sender == widget.senderMobile
                                  ? TimeWidget(time: chats[index].timestamp)
                                  : chats[index].type == Type.message
                                      ? ContentWidget(
                                          text: chats[index].text,
                                          type: Type.message,
                                        )
                                      : ContentWidget(
                                          text: chats[index].text,
                                          type: Type.image),
                              chats[index].sender != widget.senderMobile
                                  ? TimeWidget(time: chats[index].timestamp)
                                  : chats[index].type == Type.message
                                      ? ContentWidget(
                                          text: chats[index].text,
                                          type: Type.message,
                                        )
                                      : ContentWidget(
                                          text: chats[index].text,
                                          type: Type.image,
                                        ),
                            ]);
                      },
                      separatorBuilder: (context, index) {
                        if (chats[index].sender == chats[index + 1].sender) {
                          return kHeight3;
                        } else {
                          return kHeight10;
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() => _showEmoji = !_showEmoji);
                        },
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: kWhite,
                        )),
                    kWidth10,
                    Expanded(
                      child: TextField(
                        onTap: () {
                          if (_showEmoji) {
                            setState(() => _showEmoji = !_showEmoji);
                          }
                        },
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(color: kWhite),
                        controller: _messageController,
                        decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.image,
                        color: kWhite,
                      ),
                      onPressed: () async {
                        final File? img =
                            await PickAndCrop().pickImage(ImageSource.gallery);
                        log("img------>$img");
                        String imgUrl = '';
                        if (img != null) {
                          CoustumDialog().showProgress();
                          imgUrl = await uploadAndSendImage(img);
                        }
                        log('imgUrl------>$imgUrl');
                        sendMessage(imgUrl, id!, Type.image);
                        Get.back();
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: kWhite,
                      ),
                      onPressed: () async {
                        if (_messageController.text.trim().isNotEmpty) {
                          sendMessage(_messageController.text.trim(), id!,
                              Type.message);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _showEmoji,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * .35,
                  child: EmojiPicker(
                    textEditingController: _messageController,
                    config: const Config(
                      iconColorSelected: kRed,
                      indicatorColor: kRed,
                      bgColor: Colors.transparent,
                      columns: 8,
                      emojiSizeMax: 32 * (1.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  convId(String sender, String reciver) {
    List<String> list = [];
    list.addAll([sender, reciver]);
    list.sort();
    final id = list.join('');
    return id;
  }

  Future<String> uploadAndSendImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_collection_gallery')
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      final uploadTask = storageRef.putFile(File(image.path));
      final taskSnapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.toString();
    }
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.text,
    required this.type,
  });

  final String text;
  final Type type;

  @override
  Widget build(BuildContext context) {
    log(text);
    return Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        margin: const EdgeInsets.symmetric(horizontal: 10), //maatanam
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: kRed),
        child: type == Type.message
            ? Text(
                text,
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 18,
                ),
              )
            : CachedNetworkImage(imageUrl: text));
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.time,
  });

  final Timestamp? time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: time == null
          ? Icon(
              Icons.access_time,
              color: kWhite,
            )
          : Text(
              formatDate(time!.toDate()),
              style: const TextStyle(color: kWhite, fontSize: 12),
            ),
    );
  }

  String formatDate(DateTime timestamp) {
    String formattedDate = DateFormat.MMMMd().format(timestamp);
    String formattedTime = DateFormat.jm().format(timestamp);
    return "$formattedDate\n$formattedTime";
  }
}
