import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:get/get.dart';

class DeleteContactViewModel extends BaseViewModel {
  Future<void> deleteContact(Contact contact) async {
    final contactDoc = collectionReference.doc(contact.id);

    await contactDoc
        .delete()
        .whenComplete(() => success())
        .catchError((e) => showToast("Error deleting contact $e"));
  }

  void success() {
    showToast("Successfully Delete!");
    eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
    Get.back();
  }
}
