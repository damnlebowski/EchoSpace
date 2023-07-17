import 'package:firebase_auth/firebase_auth.dart';

User? getUser() {
  User? user = FirebaseAuth.instance.currentUser;
  return user;
}
