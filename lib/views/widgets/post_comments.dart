
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/functions/date_time.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openBottomSheet(BuildContext context,
      final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: kBgBlack,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * .8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kInactiveColor,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 5,
                  width: 50,
                ),
              ),
              const Text(
                'Comments',
                style: TextStyle(color: kWhite, fontSize: 16),
              ),
              const Divider(
                height: 30,
                color: kInactiveColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      (documentSnapshot.data()['comments'] as List<dynamic>)
                          .length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        (documentSnapshot.data()['comments'][index]
                            as Map<String, dynamic>)['user_name'],
                        style: const TextStyle(color: kWhite, fontSize: 13),
                      ),
                      subtitle: Text(
                        (documentSnapshot.data()['comments'][index]
                            as Map<String, dynamic>)['comment_text'],
                        style: const TextStyle(color: kWhite, fontSize: 18),
                      ),
                      trailing: Text(
                        formatDateTime(((documentSnapshot.data()['comments']
                                        [index] as Map<String, dynamic>)['time']
                                    as Timestamp)
                                .toDate())
                            .substring(0, 4),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
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
                        style: const TextStyle(color: kWhite),
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: kWhite),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: kWhite,
                      ),
                      onPressed: () {
                        if (commentController.text.trim().isNotEmpty) {
                          UserPost().addComment(
                              documentSnapshot.data()['postId'],
                              commentController.text.trim(),
                              getUser()!.phoneNumber!);
                          commentController.clear();
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }