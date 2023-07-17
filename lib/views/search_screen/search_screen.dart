import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/controllers/search_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/user_profile_screen/user_profile_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  SearchController searchObj = SearchController();

  final TextEditingController searchController = TextEditingController();

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
                    searchObj.serach(value);
                  },
                ),
              ],
            ),
          ),
        ),
        body: Obx(
          () => searchObj.userList.isNotEmpty
              ? ListView.builder(
                  itemCount: searchObj.userList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        final bool isConnected = await checkConnection(
                            searchObj.userList[index]['mobile']);

                        Get.to(() => UserProfilePage(
                              userMobile: searchObj.userList[index]['mobile'],
                              isConnected: isConnected,
                            ));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          searchObj.userList[index]['profilePhoto'],
                        ),
                        radius: 25,
                      ),
                      title: Text(
                        (searchObj.userList[index]['name'] as String)
                            .toUpperCase(),
                        style: const TextStyle(color: kWhite),
                      ),
                      subtitle: Text(
                        searchObj.userList[index]['userName'],
                        style: const TextStyle(color: kWhite),
                      ),
                    );
                  },
                )
              : const Center(
                  child: CustomText(label: 'Search User'),
                ),
        ));
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
