import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/user_model.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/user_chat_screen/user_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('user_details').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: kRed,
            ));
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}',
                style: const TextStyle(color: kWhite, fontSize: 20));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'You are the first post.',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              UserModel model =
                  UserModel.fromJson(snapshot.data!.docs[index].data());

              if (model.mobile == getUser()!.phoneNumber) {
                return const SizedBox();
              }

              return ListTile(
                onTap: () {
                  Get.to(UserChat(
                    senderMobile: getUser()!.phoneNumber!,
                    receiver: model,
                  ));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(model.profilePhoto),
                ),
                title: Text(
                  model.name,
                  style: const TextStyle(color: kWhite),
                ),
                subtitle: Text(
                  model.userName,
                  style: const TextStyle(color: kWhite),
                ),
              );
            },
          );
        });
  }
}
