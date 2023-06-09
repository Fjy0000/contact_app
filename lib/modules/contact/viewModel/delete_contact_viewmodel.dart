import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DeleteContactViewModel extends BaseViewModel {
  Future<void> deleteContact(Contact contact) async {
    final deleteDoc = collectionReference.doc(contact.id);
    Reference deleteFile = storageReference.child("${contact.id}");

    await deleteFile.delete();
    await deleteDoc.delete().whenComplete(() => success());
  }

  void success() {
    showToast("Successfully Delete!");
    eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
    Get.back();
  }
}
