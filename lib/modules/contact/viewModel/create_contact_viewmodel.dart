import 'package:app2/base/base_event_bus.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateContactViewModel {
  Future<void> saveContact(Contact contact) async {
    //save data to firebase
    final contactDoc = FirebaseFirestore.instance.collection("contact").doc();
    final json = contact.toJson();
    await contactDoc
        .set(json)
        .whenComplete(() => success())
        .catchError((e) => showToast("Error adding contact $e"));
  }

  void success() {
    showToast("Successfully Added!");
    eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
    Get.back();
  }
}
