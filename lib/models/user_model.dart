import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fcmToken;
  final String mobile;
  final String name;
  final String userName;
  final String profilePhoto;
  final String bio;
  final int posts;
  final List connections;
  final Timestamp lastSeen;
  final bool isOnline;

  UserModel(
      {required this.fcmToken,
      required this.mobile,
      required this.name,
      required this.userName,
      required this.profilePhoto,
      required this.bio,
      required this.posts,
      required this.connections,
      required this.lastSeen,
      required this.isOnline});

  Map<String, dynamic> toJson() => {
        'fcmToken': fcmToken,
        'mobile': mobile,
        'name': name,
        'userName': userName,
        'profilePhoto': profilePhoto,
        'bio': bio,
        'posts': posts,
        'connections': connections,
        'lastSeen': lastSeen,
        'is_online': isOnline,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        fcmToken: json['fcmToken'] ?? '',
        mobile: json['mobile'],
        name: json['name'],
        userName: json['userName'],
        profilePhoto: json['profilePhoto'],
        bio: json['bio'],
        posts: json['posts'],
        connections: json['connections'],
        lastSeen:
            json['lastSeen'] ,
        isOnline: json['is_online'],
      );
}
