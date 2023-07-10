import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';

AlertDialog alert(
    BuildContext context, String title, void Function() onPressed) {
  return AlertDialog(
    backgroundColor: kBgBlack,
    title: const Text(
      'Confirmation',
      style: TextStyle(color: kWhite),
    ),
    content: Text(
      title,
      style: const TextStyle(color: kWhite),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: onPressed,
        child: const Text('Yes'),
      ),
      TextButton(
        child: const Text('No'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
