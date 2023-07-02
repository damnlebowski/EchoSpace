import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/user_model.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/user_profile_screen/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key, required this.connections});

  final List<UserModel> connections;

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Connections',
          style: TextStyle(color: kWhite),
        ),
      ),
      body: connections.isEmpty
          ? const Center(
              child: Text(
              'You Have No connections',
              style: TextStyle(color: kWhite, fontSize: 20),
            ))
          : ListView.builder(
              itemCount: connections.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    final bool isConnected =
                        await checkConnection(connections[index].mobile);
                    Get.to(() => UserProfilePage(
                        userMobile: connections[index].mobile,
                        isConnected: isConnected));
                  },
                  title: Text(
                    connections[index].name.toUpperCase(),
                    style: const TextStyle(color: kWhite),
                  ),
                  subtitle: Text(
                    connections[index].userName,
                    style: const TextStyle(color: kWhite),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(connections[index].profilePhoto),
                  ),
                );
              },
            ),
    );
  }

  Future<bool> checkConnection(String mobile) async {
    final data = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(getUser()!.phoneNumber)
        .get();

    List collection = data.get('connections');
    if (collection.contains(mobile)) {
      return true;
    }
    return false;
  }
}
