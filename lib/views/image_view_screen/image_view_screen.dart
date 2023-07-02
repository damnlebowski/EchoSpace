import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
        backgroundColor: kBgBlack,
      ),
      backgroundColor: kBgBlack,
      body: Center(
        child: SingleChildScrollView(child: Image.network(image)),
      ),
    );
  }
}
