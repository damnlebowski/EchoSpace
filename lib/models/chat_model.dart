import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String text;
  final String sender;
  final String receiver;
  final Type type;
  final Timestamp? timestamp;

  Chat({
    required this.text,
    required this.sender,
    required this.receiver,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'postId': text,
        'mobile': sender,
        'userName': receiver,
        'type': type.name,
        'time': FieldValue.serverTimestamp(),
      };

  static Chat fromJson(Map<String, dynamic> json) => Chat(
        text: json['postId'],
        sender: json['mobile'],
        receiver: json['userName'],
        type: json['type'] == Type.image.name ? Type.image : Type.message,
        timestamp: json['time'],
      );
}

enum Type { message, image }
