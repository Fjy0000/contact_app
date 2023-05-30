import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReadContactViewModel extends BaseViewModel {
  RxList<Contact> contactList = RxList();

  Future<void> getData() async {
    appState.value = AppState.Loading;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('contact').get();

    contactList.clear();
    for (var document in snapshot.docs) {
      var data = document.data() as Map<String, dynamic>;

      var contact = Contact(
        name: data['name'],
        contactNo: data['contactNo'],
      );
      contactList.add(contact);
      // print(document.data());
      // print('${contactList.length}');
    }
    if (contactList.isEmpty) {
      appState.value = AppState.Empty;
    } else {
      appState.value = AppState.Success;
    }
  }
}
