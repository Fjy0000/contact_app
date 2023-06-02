import 'package:app2/base/base_event_bus.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditContactViewModel {
  Future<void> editContact(Contact contact) async {
    //save data to firebase
    final contactDoc =
        FirebaseFirestore.instance.collection("contact").doc(contact.id);

    await contactDoc
        .update({
          "name": contact.name,
          "contactNo": contact.contactNo,
          "organisation": contact.organisation,
          "email": contact.email,
          "address": contact.address,
          "note": contact.note,
        })
        .whenComplete(() => success())
        .catchError((e) => showToast("Error update contact $e"));
  }

  void success() {
    showToast("Successfully Updated!");
    eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
    Get.back();
  }
}
