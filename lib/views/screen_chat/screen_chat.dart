import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        label: "Chat Screen",
        fontSize: 16,
      ),
    );
  }
}
