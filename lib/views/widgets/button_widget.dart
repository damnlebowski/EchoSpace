import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.label,
      required this.onTap,
      required this.buttonColor});
  final String label;
  final Function() onTap;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * .90,
          height: MediaQuery.of(context).size.height * .07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: buttonColor,
          ),
          child: Center(
            child: CustomText(label: label),
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.label,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 20,
  });

  final String label;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: kWhite),
    );
  }
}
