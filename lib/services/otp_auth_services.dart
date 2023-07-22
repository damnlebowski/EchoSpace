import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  String userVerificationId = '';

  Future<void> sendOTP(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        userVerificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Code auto-retrieval timed out');
      },
      timeout: const Duration(seconds: 5),
    );
  }

  // Verifying the OTP
  Future<bool> verifyOTP(String verificationId, String smsCode) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      print(
          'User ${userCredential.user?.uid} has been successfully authenticated.');
      return true;
    } catch (e) {
      print('Verification failed: ${e.toString()}');
    }
    return false;
  }

  // User logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User logged out successfully.');
    } catch (e) {
      print('Failed to log out the user: $e');
    }
  }
}
