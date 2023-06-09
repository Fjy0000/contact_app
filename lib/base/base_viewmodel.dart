import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

enum AppState {
  Loading,
  Success,
  ComingSoon,
  Empty,
  Failed,
}

abstract class BaseViewModel extends GetxController {
  Rx<AppState> appState = AppState.Loading.obs;

  //reference to firebase database
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("contact");

  //reference to firebase storage
  Reference storageReference = FirebaseStorage.instance.ref().child('avatars');
}
