// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/models/post_models.dart';
import 'package:echospace/services/upload_post_firebase.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/views/pick_and_crop_image.dart';
import 'package:echospace/views/screen_main/screen_main.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController titleController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        backgroundColor: kBgBlack,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter The Title',
                    hintStyle: TextStyle(
                      color: kInactiveColor,
                      fontSize: 25,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kInactiveColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kWhite),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                kHeight25,
                InkWell(
                  onTap: () async {
                    image = await PickAndCrop().pickImage(ImageSource.gallery);
                    setState(() {});
                  },
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: kInactiveColor)),
                    child: image == null
                        ? Icon(
                            Icons.add_photo_alternate_sharp,
                            color: kWhite,
                            size: 100,
                          )
                        : Image.file(image!),
                  ),
                ),
                kHeight25,
                ButtonWidget(
                    label: 'Post',
                    onTap: () async {
                      if (image == null ||
                          titleController.text.trim().isEmpty) {
                        return;
                      }
                      UserPost()
                          .createPost(image!, titleController.text.trim());
                      image = null;
                      titleController.text = '';
                      setState(() {});
                      Get.snackbar(
                        'Successful',
                        'Post Created',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.grey[800],
                        colorText: Colors.red,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    buttonColor: kRed)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
