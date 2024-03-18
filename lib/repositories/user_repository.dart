import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logistics_app/services/firebase_service.dart';

class UserRepository{
  //Getters
  //Instance of firebase firestore from FirebaseService class
  final FirebaseFirestore _firestore = FirebaseService.instance.firestore;
}