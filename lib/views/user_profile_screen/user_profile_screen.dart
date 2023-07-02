// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/controllers/user_profile_connected_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/user_profile_screen/widgets/search_user_post_grid.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage(
      {super.key, required this.userMobile, required this.isConnected});
  final String userMobile;
  bool isConnected;
  ConnectedController obj = ConnectedController();

  @override
  Widget build(BuildContext context) {
    obj.changeToRxIsConnected(isConnected);

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user_details')
                      .doc(userMobile)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
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
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                obj.isConnected.value =
                                    await connectAndDisconnect(
                                        userMobile);
                              },
                              child: Obx(
                                () => Visibility(
                                  visible: FirebaseAuth
                                          .instance.currentUser!.phoneNumber !=
                                      snapshot.data?.get('mobile'),
                                  child: !obj.isConnected.value
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kRed,
                                          ),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              'Connect',
                                              style: TextStyle(color: kWhite),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kInactiveColor,
                                          ),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              'Connected',
                                              style: TextStyle(color: kWhite),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            kWidth10
                          ],
                        ),
                        kHeight10,
                        Row(
                          children: [
                            kWidth10,
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data?.get('profilePhoto')),
                              radius: 50,
                            ),
                            Spacer(),
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
                            Spacer(),
                            Column(
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
                                Text(
                                    (snapshot.data?.get('name') as String)
                                        .toUpperCase(),
                                    style:
                                        TextStyle(fontSize: 18, color: kWhite)),
                                kHeight10,
                                Text(snapshot.data?.get('bio'),
                                    style:
                                        TextStyle(fontSize: 16, color: kWhite)),
                                kHeight10,
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              const Divider(
                color: kInactiveColor,
              ),
              const CustomText(label: 'Posts'),
              kHeight10,
              SearchUserPostGrid(userMobile: userMobile),
              kHeight25,
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> connectAndDisconnect(String mobile) async {
  final user = getUser();
  final docRef = FirebaseFirestore.instance
      .collection('user_details')
      .doc(user!.phoneNumber);
  final snap = await docRef.get();

  //checking is connected or not
  if ((snap['connections'] as List<dynamic>).contains(mobile)) {
    await docRef.update({
      'connections': FieldValue.arrayRemove([mobile]),
    });
    return false;
  } else {
    await docRef.update({
      'connections': FieldValue.arrayUnion([mobile]),
    });

    return true;
  }
}
