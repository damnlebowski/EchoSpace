import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/views/screen_user_profile/screen_user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  List userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBgBlack,
        appBar: AppBar(
          backgroundColor: kBgBlack,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                color: kWhite,
              )),
          title: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: searchController,
                  style: const TextStyle(color: kWhite),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kInactiveColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kWhite),
                    ),
                    labelText: 'Search user',
                    labelStyle: TextStyle(color: kWhite),
                  ),
                  onChanged: (value) {
                    serach(value);
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                final bool isConnected =
                    await checkConnection(userList[index]['mobile']);

                Get.to(() => UserProfilePage(
                      userMobile: userList[index]['mobile'],
                      isConnected: isConnected,
                    ));
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  userList[index]['profilePhoto'],
                ),
                radius: 25,
              ),
              title: Text(
                (userList[index]['name'] as String).toUpperCase(),
                style: const TextStyle(color: kWhite),
              ),
              subtitle: Text(
                userList[index]['userName'],
                style: const TextStyle(color: kWhite),
              ),
            );
          },
        ));
  }

  serach(String querry) async {
    userList = await FirebaseFirestore.instance
        .collection('user_details')
        .where(
          'name',
          isGreaterThanOrEqualTo: searchController.text.toLowerCase(),
          isEqualTo: searchController.text.toLowerCase(),
          isLessThanOrEqualTo: searchController.text.toLowerCase(),
        )
        .get()
        .then((value) => value.docs);
    setState(() {});
  }

  Future<bool> checkConnection(String mobile) async {
    final data = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();

    List collection = data.get('connections');
    if (collection.contains(mobile)) {
      return true;
    }
    return false;
  }
}
