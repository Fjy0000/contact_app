import 'package:app2/base/base_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog_util.dart';

Future<void> requestPermission(
  List<Permission> permissions, {
  String? customMsg,
  OnSuccess<PermissionStatus>? onSuccess,
}) async {
  BuildContext context = Get.key.currentContext!;

  List<Permission> toRequestList = [];
  for (Permission permission in permissions) {
    var status = await permission.status;
    if (status.isGranted == false) {
      toRequestList.add(permission);
    }
  }

  if (toRequestList.isEmpty) {
    // isAllGranted
    onSuccess?.call(PermissionStatus.granted);
  } else {
    Map<Permission, PermissionStatus> statuses = await toRequestList.request();

    bool anyPD = statuses.values.any((element) => element.isPermanentlyDenied);
    if (anyPD) {
      showAlertDialog(
        context,
        title: 'permission_required'.tr,
        message: customMsg ??
            '${'permission_required_msg'.tr}\n${permissionString(permissions)}',
        positiveText: 'confirm'.tr,
        negativeText: 'cancel'.tr,
        onPositivePressed: () {
          openAppSettings();
        },
      );
    } else {
      bool anyD = statuses.values.any((element) => element.isDenied);
      if (anyD) {
        onSuccess?.call(PermissionStatus.denied);
      } else {
        onSuccess?.call(PermissionStatus.granted);
      }
    }
  }
}

String permissionString(List<Permission> permissions) {
  String str = '';
  for (Permission permission in permissions) {
    str += '- ${permission.toString()}\n';
  }
  return str;
}
