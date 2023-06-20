import 'dart:async';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/main.dart';
import 'package:app2/modules/contact/argument/contact_details_argument.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_avatar.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContactQrPage extends StatefulWidget {
  const ContactQrPage({Key? key}) : super(key: key);

  @override
  State<ContactQrPage> createState() => _ContactQrPageState();
}

class _ContactQrPageState extends State<ContactQrPage> {
  ContactArgument arguments = Get.arguments;

  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

    subscription = eventBus?.on<BaseEventBus>().listen((event) {
      switch (event.type) {
        case EventBusAction.REFRESH_CONTACT:
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        backgroundColor: Colors.transparent,
        "Contact QR Code",
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            decoration: BoxDecoration(
                color: const Color(0x33e8e8e8),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseAvatar(
                  isImagePath: true,
                  imagePath: arguments.contact?.imagePath,
                ),
                const SizedBox(height: 15),
                BaseText(
                  arguments.contact?.name ?? "-",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 20),
                QrImage(
                  data: arguments.contact?.contactNo.toString() ?? '',
                  version: QrVersions.auto,
                  size: 180,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
