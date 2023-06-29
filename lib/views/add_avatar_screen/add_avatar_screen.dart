import 'dart:io';
import 'package:echospace/controllers/avatar_controller.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/models/user_model.dart';
import 'package:echospace/services/uplode_profile_image_firebase_storage.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/add_avatar_screen/widgets/image_widget.dart';
import 'package:echospace/views/pick_and_crop_image.dart';
import 'package:echospace/views/screen_main/screen_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

XFile? imgFile;

class AddAvatarPage extends StatelessWidget {
  final avatarObj = AvatarController();
  AddAvatarPage({
    super.key,
    required this.profileDetails,
  });
  final Map<String, String> profileDetails;
  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg01.jpg?alt=media&token=7badbe39-7e2e-42f3-ac39-e2d30ab51ec3',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg02.jpg?alt=media&token=2c665be4-f789-4717-8971-bc02dbae2826',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg03.jpg?alt=media&token=8faaa131-7e8b-4a75-b955-e309f73b7df1',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg04.jpg?alt=media&token=009b073c-2d61-4f28-a9aa-414fc93def37',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg05.jpg?alt=media&token=1dda28b0-666d-4b90-8a49-1146902586dd',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg06.jpg?alt=media&token=f6f81970-4b9c-41c5-853d-87d4293c6514',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg07.jpg?alt=media&token=d76771c8-c86d-4eb7-ac32-ce2291d22951',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg08.jpg?alt=media&token=426e9503-edb8-40cd-aa97-efd6c2d7b03a',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg09.jpg?alt=media&token=09b33369-a329-4e02-865f-fa4beb64b4c1',
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg10.jpg?alt=media&token=b63122fd-460a-4537-95a7-a20d4507eb24'
    ];
    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBgBlack,
        title: Image.asset(
          'assests/EchoSpace.png',
          width: 200,
        ),
      ),
      body: Center(
        child: Column(children: [
          kHeight10,
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => CircleAvatar(
                    radius: 120,
                    backgroundImage: avatarObj.galleryImg == ''.obs
                        ? NetworkImage(avatarObj.appImg.value)
                        : FileImage(File(avatarObj.galleryImg.value))
                            as ImageProvider,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: InkWell(
                  onTap: () {
                    takePhoto();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kInactiveColor,
                        borderRadius: BorderRadius.circular(15)),
                    height: 50,
                    width: 50,
                    child: const Icon(
                      Icons.image,
                      color: kWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
          kHeight10,
          const Divider(
            color: kInactiveColor,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    avatarObj.onClick(imgList[index]);
                  },
                  child: InAppImage(img: imgList[index])),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            ),
          ))
        ]),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          uploadDetails();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .40,
          height: MediaQuery.of(context).size.height * .07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: kRed,
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kWhite, fontSize: 20),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> takePhoto() async {
    File? tempImgFile = await PickAndCrop().pickImage(ImageSource.gallery);
    XFile? pickedFile = XFile(tempImgFile!.path);
    if (pickedFile != null) {
      avatarObj.galleryImg.value = pickedFile.path;
      avatarObj.appImg.value = '';
      imgFile = pickedFile;
    }
  }

  uploadDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    String? imgUrl;
    if (avatarObj.appImg.value == '') {
      //uploading image to firebase and getting the network url back
      imgUrl = await UplodeProfileImageFirebase()
          .imageToUrlProfilePic(user!.phoneNumber!, imgFile!);
    }

    //user model

    UserModel model = UserModel(
        mobile: user!.phoneNumber!,
        name: (profileDetails['name']!).toLowerCase(),
        userName: (profileDetails['userName']!).toLowerCase(),
        profilePhoto:
            avatarObj.appImg.value == '' ? imgUrl! : avatarObj.appImg.value,
        bio: 'I am using EchoSpace',
        posts: 0,
        connections: []);

    //save user details to firebase
    UserDetails().addDetailsOfUser(model);
    Get.to(() => MainScreen());
  }
}
