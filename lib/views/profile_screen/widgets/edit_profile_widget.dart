import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/controllers/edit_profile_widget_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/uplode_profile_image_firebase_storage.dart';
import 'package:echospace/utils/functions/pick_and_crop_image.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileAlertDialog extends StatelessWidget {
  EditProfileAlertDialog({super.key, required this.doc});

  final DocumentSnapshot<Map<String, dynamic>> doc;
  EditProfileWidgetController obj = EditProfileWidgetController();
  // String? img;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: (doc.get('name') as String).toUpperCase());
    final TextEditingController bioController =
        TextEditingController(text: doc.get('bio'));

    return AlertDialog(
      backgroundColor: kBgBlack,
      title: const Text(
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
              obj.img.value = imageFile.path;
            },
            child: Obx(
              () => CircleAvatar(
                backgroundImage: obj.img.value == null
                    ? NetworkImage(doc.get('profilePhoto'))
                    : FileImage(File(obj.img.value!)) as ImageProvider,
                radius: 40,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: kWhite),
            controller: nameController,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kInactiveColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhite),
                ),
                hintText: 'Enter name',
                hintStyle: TextStyle(color: kWhite)),
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: kWhite),
            controller: bioController,
            decoration: const InputDecoration(
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
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(kRed)),
          onPressed: () async {
            log('${obj.img.value}');
            // Implement submit logic here
            if (nameController.text.trim().isEmpty ||
                bioController.text.trim().isEmpty) {
              return;
            }
            final String imgUrl;
            if (obj.img.value != null) {
              imgUrl = await UplodeProfileImageFirebase().imageToUrlProfilePic(
                  getUser()!.phoneNumber!, XFile(File(obj.img.value!).path));
            } else {
              imgUrl = doc.get('profilePhoto');
            }

            updateDetails(doc, nameController.text.trim().toLowerCase(),
                bioController.text.trim(), imgUrl);
            Get.back();
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: kWhite),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(kRed)),
          onPressed: () {
            Get.back();
          },
          child: const Text(
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
