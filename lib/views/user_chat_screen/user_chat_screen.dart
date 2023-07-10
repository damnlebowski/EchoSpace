// ignore_for_file: prefer_const_constructors

import 'package:echospace/models/user_model.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserChat extends StatelessWidget {
  UserChat({
    super.key,
    required this.sender,
    required this.receiver,
  });
  final String sender;
  final UserModel receiver;

  final TextEditingController _messageController = TextEditingController();
  late String? id;

  Future<void> _sendMessage(String message) async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('chats')
        .doc(id)
        .collection('messages');
    _messageController.clear();

    await collection.add({
      'text': message,
      'sender': sender,
      'receiver': receiver.mobile,
      'timestamp': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    id = convId(sender, receiver.mobile);

    return Scaffold(
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
          receiver.userName,
          style: TextStyle(color: kWhite),
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
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kRed,
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Message Yet.',
                      style: TextStyle(color: kWhite, fontSize: 20),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: snapshot.data!.docs[index]['sender'] == sender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                snapshot.data!.docs[index]['sender'] == sender
                                    ? const EdgeInsets.fromLTRB(70, 10, 10, 10)
                                    : const EdgeInsets.fromLTRB(10, 10, 70, 10),
                            padding:
                                snapshot.data!.docs[index]['sender'] == sender
                                    ? const EdgeInsets.fromLTRB(10, 10, 20, 15)
                                    : const EdgeInsets.fromLTRB(20, 10, 10, 15),
                            decoration: BoxDecoration(
                              color:
                                  snapshot.data!.docs[index]['sender'] == sender
                                      ? kRed
                                      : kRed,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              snapshot.data!.docs[index]['text'],
                              style: TextStyle(color: kWhite, fontSize: 18),
                            ),
                          ),
                          Positioned(
                              bottom: 11,
                              right:
                                  snapshot.data!.docs[index]['sender'] == sender
                                      ? 18
                                      : null,
                              left:
                                  snapshot.data!.docs[index]['sender'] == sender
                                      ? null
                                      : 18,
                              child: Text(
                                (snapshot.data?.docs[index]['timestamp']
                                        as Timestamp)
                                    .toDate()
                                    .toString()
                                    .substring(11, 16),
                                style: TextStyle(color: kWhite, fontSize: 12),
                              ))
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: kWhite),
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: kWhite)),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: kWhite,
                  ),
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _sendMessage(_messageController.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
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
}
