import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logistics_app/controllers/core_controllers/initialize_app_controller.dart';
import 'package:logistics_app/repositories/auth_repository.dart';

class SignInController extends GetxController{
  static SignInController get instance => Get.find();
  final AuthRepository _authRepository = AuthRepository();
  
  //sign user in with phone number
  signInWithPhoneAuthCredential(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _authRepository.signInWithPhoneAuthCredential(credential);
      User user = userCredential.user!;
      //initialize app method, To route user to the apprioprate screen.
      InitializeAppController.instance.initializeApp(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          Get.snackbar("Invalid OTP code",
              "Please check and enter the correct verification code again");
          break;
        default:
          Get.snackbar(
              "Sign in Exception", "Something went wrong, please try again");
      }
    } catch (e) {
      Get.snackbar(
          "Oops!", "Something went wrong during sign in, please try again");
    }
  }
}