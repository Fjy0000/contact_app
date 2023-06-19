import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReadContactViewModel extends BaseViewModel {
  RxList<ContactBean> contactList = RxList();

  Future<void> getData() async {
    appState.value = AppState.Loading;

    QuerySnapshot snapshot = await collectionReference.get();
    contactList.clear();
    for (var document in snapshot.docs) {
      var data = document.data() as Map<String, dynamic>;

      var contact = ContactBean(
        id: data['id'],
        name: data['name'],
        contactNo: data['contactNo'],
        organisation: data['organisation'],
        email: data['email'],
        address: data['address'],
        note: data['note'],
        imagePath: data['imagePath'],
      );

      contactList.add(contact);
    }
    if (contactList.isEmpty) {
      appState.value = AppState.Empty;
    } else {
      appState.value = AppState.Success;
    }
  }

  Future<void> deleteContact(ContactBean contact) async {
    final deleteDoc = collectionReference.doc(contact.id);
    final storageFile = storageReference.child("${contact.id}");

    await deleteDoc.delete().request(onSuccess: (v) async {
      await storageFile.delete();
      showToast("Successfully Delete!");
      eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
      Get.back();
    });
  }
}
