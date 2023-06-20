import 'dart:io';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/dialog_util.dart';
import 'package:app2/utils/extension.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class EditContactViewModel extends BaseViewModel {
  Future<void> editContact(bool? isChangeAvatar, ContactBean contact) async {
    String avatarUrl = contact.imagePath ?? '';
    bool _isLoadingDialogShown = false;

    final contactDoc = collectionReference.doc(contact.id);
    final refUploadAvatarName = storageReference.child("${contact.id}");

    if (isChangeAvatar == true) {
      refUploadAvatarName
          .putFile(File("${contact.imagePath}"))
          .snapshotEvents
          .listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            if (!_isLoadingDialogShown) {
              showLoadingDialog();
              _isLoadingDialogShown = true;
            }
            break;
          case TaskState.paused:
            print("upload image paused");
            break;
          case TaskState.canceled:
            print("upload image canceled");
            break;
          case TaskState.error:
            showToast('save contact fail');
            break;
          case TaskState.success:
            avatarUrl = await refUploadAvatarName.getDownloadURL();
            await contactDoc.update({
              'name': contact.name,
              'contactNo': contact.contactNo,
              'organisation': contact.organisation,
              'email': contact.email,
              'address': contact.address,
              'note': contact.note,
              'imagePath': avatarUrl,
            }).request(onSuccess: (value) {
              dismissDialog();
              showToast("Successfully Updated!");
              eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
              Get.back();
            });
            break;
        }
      });
    } else {
      await contactDoc.update({
        'name': contact.name,
        'contactNo': contact.contactNo,
        'organisation': contact.organisation,
        'email': contact.email,
        'address': contact.address,
        'note': contact.note,
      }).request(onSuccess: (value) {
        showToast("Successfully Updated!");
        eventBus?.fire(BaseEventBus(EventBusAction.REFRESH_CONTACT));
        Get.back();
      });
    }
  }
}
