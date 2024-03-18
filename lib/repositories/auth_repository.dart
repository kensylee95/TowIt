import 'package:firebase_auth/firebase_auth.dart';
import 'package:logistics_app/services/firebase_service.dart';

class AuthRepository {
  //Instance of firebase auth class from FirebaseService class
  final FirebaseAuth _auth = FirebaseService.instance.auth;
  //Method that signs user in via phonumber with and returns there credential
  signInWithPhoneAuthCredential(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  //Method that verifies phonenumber upon sign in attempt
  Future verifyPhoneNumber(
      String phoneNumber,
      Function(String, int?) onCodeSent,
      Function(PhoneAuthCredential credential) verified,
      Function(FirebaseAuthException) onVerificationFailed) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verified,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: (string) {},
        timeout: const Duration(seconds: 60));
  }
}
