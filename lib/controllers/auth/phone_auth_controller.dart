import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/controllers/auth/sign_in_controller.dart';
import 'package:logistics_app/repositories/auth_repository.dart';
import 'package:logistics_app/utils/helpers.dart';
import 'package:logistics_app/views/auth/phone_verification.dart';
import 'package:pinput/pinput.dart';

class PhoneAuthController extends GetxController {
  final SignInController _signInController = Get.put(SignInController());
  //instance of AuthRepository class
  final AuthRepository _authRepository = AuthRepository();
  //Getter for this class implementing Getx Get.find()
  static PhoneAuthController get instance => Get.find();
  //TextEditingController for phone number Textfield
  final TextEditingController phoneNumber = TextEditingController();
  //Getx Rx variable of TextEditingController for verification code PinPut textfield
  //to update the TextField automatically after verication
  Rx<TextEditingController> verificationCode = Rx(TextEditingController());
  //Method called from SignIn Screen to verify phone number
  //after user enters phone number in the textfield
  verifyPhoneNumber(String phoneNumber) async {
    final formattedPhoneNumber = formatNigerianPhoneNumber(phoneNumber);
    await _authRepository.verifyPhoneNumber(formattedPhoneNumber, _onCodeSent,
        _onCodeVerified, _onVerificationFailed);
  }

  //call back for verifyPhoneNumber method called after code have been sent to user
  void _onCodeSent(String verificationId, int? resendToken) {
    Get.to(() => PhoneVerification(
          verificationId: verificationId,
          resendToken: resendToken,
        ));
  }

  //call back for verifyPhoneNumber method, called upon verification completion
  _onCodeVerified(PhoneAuthCredential credential) async {
    verificationCode.value.setText(credential.smsCode!);
    //sign user in with phone number
    await _signInController.signInWithPhoneAuthCredential(credential);
  }

  //call back for verifyPhoneNumber method, called if verification attempt fails with exceptions
  _onVerificationFailed(FirebaseAuthException exception) {
    Get.snackbar("Verification failed",
        "Something went wrong during verification, please try again");
    //print("Verification attempt failed:, ${exception.message}");
  }

  //manually verify the one time password sent to user
  //after user enters the otp sent to them in the phoneverification screen this method is called
  void verifyOtp(String otp, String verificationId) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    //sign user in with phone number
    await SignInController.instance.signInWithPhoneAuthCredential(credential);
  }


  @override
  void dispose() {
    phoneNumber.dispose();
    verificationCode.value.dispose();
    super.dispose();
  }
}
