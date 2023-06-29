class UserModel {
  final String mobile;
  final String name;
  final String userName ;
  final String profilePhoto;
  final String bio;
  final int posts;
  final List connections;

  UserModel(
      {required this.mobile,
      required this.name,
      required this.userName,
      required this.profilePhoto,
      required this.bio,
      required this.posts,
      required this.connections});

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'name': name,
        'userName': userName,
        'profilePhoto': profilePhoto,
        'bio': bio,
        'posts': posts,
        'connections': connections,
      };

  UserModel fromJson(Map<String, dynamic> json) => UserModel(
        mobile: json['mobile'],
        name: json['name'],
        userName: json['userName'],
        profilePhoto: json['profilePhoto'],
        bio: json['bio'],
        posts: json['posts'],
        connections: json['connections'],
      );
}
