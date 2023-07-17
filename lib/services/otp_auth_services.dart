import 'dart:developer';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIdenty = '';
  Future<void> sendOtp(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) async {},
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationIdenty = verificationId;
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIdenty, smsCode: otp);

      await auth.signInWithCredential(credential);
      log('Success');
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
  
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User logged out successfully.');
    } catch (e) {
      print('Failed to log out the user: $e');
    }
  }
}
