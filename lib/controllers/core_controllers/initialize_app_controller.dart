import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logistics_app/services/firebase_service.dart';
import 'package:logistics_app/views/auth/sign_in.dart';
import 'package:logistics_app/views/core/location_details.dart';
import 'package:permission_handler/permission_handler.dart';

class InitializeAppController extends GetxController {
  //getter for this class instance
  static InitializeAppController get instance => Get.find();
  //insatance of firebaseService class
  final FirebaseService _firebaseService = FirebaseService.instance;
  //late  variable to hold the current FirebaseAuth
  late FirebaseAuth _auth;
  //Getter for current firebase authenticated user
  User? get user => _auth.currentUser;
//Rx variable that holds the current authenticated user
  final Rx<User?> _user = Rx<User?>(null);
  @override
  void onInit() async {
    //Get location permission
    await _locationPermission();
    //Initiatializing the late variable "_auth"
    _auth = _firebaseService.auth;
    //Listening to firebase auth changes and updating the "_user" Rx variable accordingly
    _user.bindStream(_auth.authStateChanges());
    //inializing the ever worker to Listen to "_user" Rx variable for changes to auth states
    // and updating our UI and rest of app accordingly
    ever(_user, (currentUser) => initializeApp(currentUser));
    //initialize our app with the current authenticated user
    initializeApp(_auth.currentUser);
    super.onInit();
  }

  Future _locationPermission() async {
    // final bool isLocationDisabled = await Permission.location.serviceStatus.isDisabled;
  
    await Permission.locationWhenInUse
        .onDeniedCallback(() {
          Get.snackbar("Location Permission Denied",
              "Please, Location services is required to use this app");
          return;
        })
        .onPermanentlyDeniedCallback(() {
          //redirect to a widget that requests the user to enable grant location permission
          Get.snackbar("location services perm. denied",
              "Enable location services from device settings");

          openAppSettings();
          return;
        })
        .onRestrictedCallback(() {
          Get.snackbar("Location Permission Restricted",
              "Location services is required to run this app");
          return;
        })
        .onGrantedCallback(() => {})
        .request();
  }

  //initialize app method with current authenticated user
  initializeApp(User? user) {
    if (user == null) {
      Get.offAll(() => const SignIn());
    } else {
      Get.offAll(() => const LocationDetails());
    }
  }

  @override
  void dispose() {
    _firebaseService.dispose();
    super.dispose();
  }
}
