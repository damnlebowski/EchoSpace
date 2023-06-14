import 'package:echospace/views/screen_splash/screen_splash.dart';
import 'package:flutter/material.dart';

import 'core/constants/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: swatchWhite),
      home: Splash(),
    );
  }
}
