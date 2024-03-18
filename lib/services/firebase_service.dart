import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:logistics_app/firebase_options.dart';

class FirebaseService extends GetxController {
  //Getters
  //Get instance of this FirebaseService class
  static FirebaseService get instance => Get.find();
  //Getter for Firestore
  FirebaseFirestore get firestore => _firestore;
  //Getter for FirebaseAuth
  FirebaseAuth get auth => _firebaseAuth;

  //Firestore instance
  late FirebaseFirestore _firestore;
  //FirebaseAuth instance
  late FirebaseAuth _firebaseAuth;

  //Initialize Firebase
  Future<void> initializeApp() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _firestore = FirebaseFirestore.instance;
      _firebaseAuth = FirebaseAuth.instance;
    } catch (e) {
      throw Exception("Failed to initialize Firebase: $e");
    }
  }
}
