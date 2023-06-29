import 'package:echospace/core/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.lableText,
    required this.controller,
    this.isobscure = false,
    this.keyboardType,
    this.maxLength,
    this.validator,
  });
  final String lableText;
  final TextEditingController controller;
  final bool isobscure;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        obscureText: isobscure,
        controller: controller,
        style: const TextStyle(color: kWhite),
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterStyle: const TextStyle(
            color: kWhite,
          ),
          labelText: lableText,
          labelStyle: const TextStyle(color: kWhite),
          filled: true,
          fillColor: kInactiveColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}