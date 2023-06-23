import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constant.dart';

void showLoadingDialog() {
  Future.delayed(Duration.zero, () {
    showDialog(
        context: Get.key.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text(
                    "${'loading'.tr}....",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        });
  });
}

void dismissDialog() {
  Navigator.pop(Get.key.currentContext!);
}

void showAlertDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? positiveText,
  String? negativeText,
  bool isCancelable = false,
  VoidCallback? onPositivePressed,
  VoidCallback? onNegativePressed,
}) async {
  Widget? positiveBtn;
  if (positiveText != null) {
    positiveBtn = TextButton(
      child: Text(
        positiveText,
        style: const TextStyle(color: AppTheme.BLACK24),
      ),
      onPressed: () {
        if (onPositivePressed != null) {
          onPositivePressed();
        }
        Navigator.pop(Get.key.currentContext!);
      },
    );
  }

  Widget? negativeBtn;
  if (negativeText != null) {
    negativeBtn = TextButton(
      child: Text(
        negativeText,
        style: const TextStyle(color: AppTheme.BLACK24),
      ),
      onPressed: () {
        if (onNegativePressed != null) {
          onNegativePressed();
        }
        Navigator.pop(Get.key.currentContext!);
      },
    );
  }

  List<Widget> actions = [];
  if (negativeBtn != null) {
    actions.add(negativeBtn);
  }
  if (positiveBtn != null) {
    actions.add(positiveBtn);
  }

  Widget? titleWidget;
  if (title != null) {
    titleWidget = BaseText(title,color: AppTheme.BLACK24,);
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: isCancelable,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return isCancelable;
        },
        child: AlertDialog(
          title: titleWidget,
          content: message?.isNotEmpty == true
              ? BaseText(
                  message,
                  color: AppTheme.BLACK24,
                )
              : null,
          actions: actions,
        ),
      );
    },
  );
}

// showCustomDialog(
//   BuildContext context,
//   Widget? content, {
//   bool isCancelable = false,
// }) {
//   AlertDialog alertDialog = AlertDialog(
//     contentPadding: EdgeInsets.zero,
//     backgroundColor: Colors.transparent,
//     insetPadding: const EdgeInsets.symmetric(horizontal: 32),
//     content: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//             width: MediaQuery.of(context).size.width,
//             // height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(22),
//               color: Colors.transparent,
//             ),
//             child: content),
//       ],
//     ),
//   );
//
//   showDialog(
//     context: context,
//     barrierColor: Colors.black54,
//     barrierDismissible: isCancelable,
//     builder: (BuildContext context) {
//       return alertDialog;
//     },
//   );
// }
//
// Future<void> showCustomBottomSheet(
//   BuildContext context,
//   Widget content,
// ) {
//   FocusManager.instance.primaryFocus?.unfocus();
//   return showModalBottomSheet<void>(
//     context: context,
//     isScrollControlled: true,
//     barrierColor: Colors.black.withOpacity(0.5),
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return Container(
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.6,
//         ),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           color: Colors.white,
//         ),
//         clipBehavior: Clip.hardEdge,
//         child: content,
//       );
//     },
//   );
// }

// Future<void> showDatePickerDialog(BuildContext context, String title, Function(DateTime) onDateTimeCallBack, {DateTime? defaultDateTime}) {
//   DateTime selectedDateTime = defaultDateTime ?? DateTime.now();
//   return showCustomBottomSheet(
//       context,
//       SelectionDialogWidget(
//         SpinnerDateTimePicker(
//           initialDateTime: defaultDateTime ?? DateTime.now(),
//           maximumDate: DateTime.now(),
//           minimumDate:
//               DateTime.now().subtract(const Duration(days: (365 * 100))),
//           mode: CupertinoDatePickerMode.date,
//           use24hFormat: true,
//           didSetTime: (value) {
//             selectedDateTime = value;
//           },
//         ),
//         title: title,
//         rightBtnText: "confirm".tr,
//         rightBtnOnPress: () {
//           // appRouter.pop();
//           Navigator.of(context).pop();
//           onDateTimeCallBack.call(selectedDateTime);
//         },
//         showCloseBtn: true,
//       ));
// }

// void showSuccessDialog(BuildContext context, Widget body) {
//   showDialog(
//     context: context,
//     barrierColor: Colors.black.withOpacity(0.5),
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return Material(
//         type: MaterialType.transparency,
//         child: Center(
//           child: Stack(
//             alignment: Alignment.topCenter,
//             fit: StackFit.loose,
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(28),
//                   color: const Color(0xfff8f8f8),
//                 ),
//                 margin: const EdgeInsets.only(top: 90 / 2, left: 24, right: 24),
//                 padding: const EdgeInsets.only(
//                     top: 90 / 2, left: 40, right: 40, bottom: 25),
//                 child: body,
//               ),
//               Positioned(
//                 child: imageAsset(
//                   res: 'ic_success_message.svg',
//                   width: 90,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// void showDownloadDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierColor: Colors.transparent,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return Material(
//         type: MaterialType.transparency,
//         child: Center(
//           child: Stack(
//             alignment: Alignment.topCenter,
//             fit: StackFit.loose,
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   image: const DecorationImage(
//                     image:
//                         AssetImage("assets/images/ic_download_background.png"),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                   gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [Color(0xff013c52), Color(0xff00060e)],
//                   ),
//                 ),
//                 margin:
//                     const EdgeInsets.only(top: 116 / 3, left: 32, right: 32),
//                 // margin: const EdgeInsets.symmetric(horizontal: 32),
//                 padding: const EdgeInsets.only(
//                     top: 116 / 2, left: 40, right: 40, bottom: 25),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       height: 29,
//                     ),
//                     const SizedBox(
//                       height: 29,
//                     ),
//                     Text(
//                       "app_name".tr,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: "PlusJakartaSans",
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       "detect_your_havent_download_desc".tr,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontFamily: "PlusJakartaSans",
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     ButtonDownload('ic_google_play.png'),
//                     const SizedBox(
//                       height: 19,
//                     ),
//                     ButtonDownload('ic_app_store.png'),
//                     const SizedBox(
//                       height: 19,
//                     ),
//                     ButtonDownload('ic_harmony_os.png'),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 child: imageAsset(
//                   res: 'ic_download_logo.png',
//                   width: 116,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// showSelectionDialog(BuildContext context, List<Widget> content) {
//   AlertDialog alertDialog = AlertDialog(
//     contentPadding: EdgeInsets.zero,
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     insetPadding: EdgeInsets.zero,
//     content: GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         dismissDialog();
//       },
//       child: Center(
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: content,
//             )),
//       ),
//     ),
//   );
//
//   showDialog(
//     context: context,
//     barrierColor: Colors.black.withOpacity(0.7),
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return alertDialog;
//     },
//   );
// }
//
// enum AlertDialogIcon { warning, success, failed, none }

// extension AlertDialogIconEx on AlertDialogIcon {
//   String get icon {
//     switch (this) {
//       case AlertDialogIcon.success:
//         return "ic_dialog_success.png";
//       case AlertDialogIcon.failed:
//         return "ic_dialog_failed.png";
//       default:
//         return "ic_dialog_warning.png";
//     }
//   }
// }
