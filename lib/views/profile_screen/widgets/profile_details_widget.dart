import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/user_model.dart';
import 'package:echospace/services/user_connections.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/views/connections_screen/connections_screen.dart';
import 'package:echospace/views/profile_screen/widgets/edit_profile_widget.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:get/get.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_details')
            .doc(getUser()!.phoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          List connections = snapshot.data?.get('connections');
          int postCount = snapshot.data?.get('posts');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  kWidth10,
                  CustomText(label: snapshot.data?.get('userName')),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              EditProfileAlertDialog(doc: snapshot.data!),
                        );
                      },
                      icon: const Icon(
                        Icons.edit_note_sharp,
                        color: kWhite,
                      )),
                  kWidth10
                ],
              ),
              kHeight10,
              Row(
                children: [
                  kWidth10,
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data?.get('profilePhoto')),
                    radius: 50,
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        'Posts',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$postCount',
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      List<UserModel> connectionList =
                          await UserConnections().getAllConnections();
                      Get.to(() {
                        return ConnectionPage(
                          connections: connectionList,
                        );
                      });
                    },
                    child: Column(
                      children: [
                        const Text(
                          'Connections',
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${connections.length}',
                          style: const TextStyle(
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kWidth10,
                ],
              ),
              kHeight10,
              Row(
                children: [
                  kWidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight10,
                      Text((snapshot.data?.get('name') as String).toUpperCase(),
                          style: const TextStyle(fontSize: 18, color: kWhite)),
                      kHeight10,
                      Text(snapshot.data?.get('bio'),
                          style: const TextStyle(fontSize: 16, color: kWhite)),
                      kHeight10,
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}
