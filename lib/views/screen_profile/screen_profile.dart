// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_local_variable, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/services/uplode_profile_image_firebase_storage.dart';
import 'package:echospace/views/pick_and_crop_image.dart';
import 'package:echospace/views/screen_post_view/screen_post_view.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user_details')
                    .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
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
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => EditProfileAlertDialog(
                                      doc: snapshot.data!),
                                );
                              },
                              icon: Icon(
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user_posts')
                    .where('mobile',
                        isEqualTo:
                            FirebaseAuth.instance.currentUser!.phoneNumber)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: CustomText(
                      label: 'No Posts Yet..',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ));
                  }
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(() => ViewPostPage(
                            documentSnapshot: snapshot.data!.docs[index]));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapshot.data?.docs[index]
                                      .get('imageUrl'))))),
                    ),
                  );
                }),
            kHeight25,
          ],
        ),
      ),
    );
  }
}

class EditProfileAlertDialog extends StatefulWidget {
  EditProfileAlertDialog({super.key, required this.doc});

  final DocumentSnapshot<Map<String, dynamic>> doc;

  @override
  State<EditProfileAlertDialog> createState() => _EditProfileAlertDialogState();
}

class _EditProfileAlertDialogState extends State<EditProfileAlertDialog> {
  String? img;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
        text: (widget.doc.get('name') as String).toUpperCase());
    final TextEditingController bioController =
        TextEditingController(text: widget.doc.get('bio'));

    return AlertDialog(
      backgroundColor: kBgBlack,
      title: Text(
        'Edit Profile',
        style: TextStyle(color: kWhite),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () async {
              File? imageFile =
                  await PickAndCrop().pickImage(ImageSource.gallery);
              if (imageFile == null) {
                return;
              }
              img = imageFile.path;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundImage: img == null
                  ? NetworkImage(widget.doc.get('profilePhoto'))
                  : FileImage(File(img!)) as ImageProvider,
              radius: 40,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            style: TextStyle(color: kWhite),
            controller: nameController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kInactiveColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhite),
                ),
                hintText: 'Enter name',
                hintStyle: TextStyle(color: kWhite)),
          ),
          SizedBox(height: 10),
          TextField(
            style: TextStyle(color: kWhite),
            controller: bioController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kInactiveColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhite),
                ),
                hintText: 'Enter bio',
                hintStyle: TextStyle(color: kWhite)),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kRed)),
          onPressed: () async {
            // Implement submit logic here
            if (nameController.text.trim().isEmpty ||
                bioController.text.trim().isEmpty) {
              return;
            }
            final String imgUrl;
            if (img != null) {
              print('File(img!).path -> ${File(img!).path}');
              print('img -> $img');
              imgUrl = await UplodeProfileImageFirebase().imageToUrlProfilePic(
                  FirebaseAuth.instance.currentUser!.phoneNumber!,
                  XFile(File(img!).path));
            } else {
              imgUrl = widget.doc.get('profilePhoto');
            }

            updateDetails(widget.doc, nameController.text.trim().toLowerCase(),
                bioController.text.trim(), imgUrl);
            Get.back();
          },
          child: Text(
            'Submit',
            style: TextStyle(color: kWhite),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kRed)),
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: kWhite),
          ),
        ),
      ],
    );
  }

  updateDetails(DocumentSnapshot<Map<String, dynamic>> doc, String name,
      String bio, String imgUrl) {
    doc.reference.update({'name': name, 'bio': bio, 'profilePhoto': imgUrl});
  }
}
