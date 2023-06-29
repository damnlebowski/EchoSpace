import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String mobile;
  final String userName;
  final String imageUrl;
  final String title;
  final Timestamp time;
  final List likes;
  final List saved;
  final List comments;

  Post({
    required this.userName,
    required this.postId,
    required this.mobile,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.likes,
    required this.saved,
    required this.comments,
  });

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'mobile': mobile,
        'userName': userName,
        'imageUrl': imageUrl,
        'title': title,
        'time': time,
        'likes': likes,
        'saved': saved,
        'comments': comments,
      };

  static Post fromJson(Map<String, dynamic> json) => Post(
        postId: json['postId'],
        mobile: json['mobile'],
        userName: json['userName'],
        imageUrl: json['imageUrl'],
        title: json['title'],
        time: json['time'],
        likes: json['likes'],
        saved: json['saved'],
        comments: json['comments'],
      );
}
