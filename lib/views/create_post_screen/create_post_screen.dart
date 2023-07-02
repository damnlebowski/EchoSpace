import 'package:echospace/controllers/create_post_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/utils/functions/pick_and_crop_image.dart';
import 'package:echospace/views/user_register_screen/user_register_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  TextEditingController titleController = TextEditingController();

  CreatePostController obj = CreatePostController();

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
                  decoration: const InputDecoration(
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                kHeight25,
                InkWell(
                  onTap: () async {
                    await onImageSelect();
                  },
                  child: Obx(
                    () => Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: kInactiveColor)),
                      child: obj.image.value == null
                          ? const Icon(
                              Icons.add_photo_alternate_sharp,
                              color: kWhite,
                              size: 100,
                            )
                          : Image.file(obj.image.value!),
                    ),
                  ),
                ),
                kHeight25,
                ButtonWidget(
                    label: 'Post',
                    onTap: () async {
                      if (obj.image.value == null ||
                          titleController.text.trim().isEmpty) {
                        return;
                      }
                      onPostClick();
                    },
                    buttonColor: kRed)
              ],
            ),
          ),
        ),
      ),
    );
  }

   onPostClick() async {
    await UserPost().createPost(obj.image.value!, titleController.text.trim());
    obj.image.value = null;
    titleController.text = '';
    snack('Successful', 'Post Created');
  }

  onImageSelect() async {
    obj.image.value = await (PickAndCrop().pickImage(ImageSource.gallery));
  }
}
