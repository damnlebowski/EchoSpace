import 'package:echospace/core/constants/colors.dart';
import 'package:flutter/material.dart';

class InAppImage extends StatelessWidget {
  InAppImage({
    super.key,
    required this.img,
  });
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kInactiveColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
          image: DecorationImage(image: NetworkImage(img))),
      height: 150,
      width: 150,
    );
  }
}