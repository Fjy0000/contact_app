import 'dart:async';

import 'package:app2/main.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/utils/image_utils.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer? _timer;
  bool isTime = false;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 1000), timeout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff6a11cb),
            Color(0xff2575fc),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.17),
                  blurRadius: 4,
                  offset: const Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: imageAsset(
                res: "ic_launcher.png",
                width: 150,
                height: 150,
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Future<void> timeout() async {
    isTime = true;
    checkLogin();
  }

  void checkLogin() {
    // if (box.read(StoreBox.USER_OBJECT) == null) {
    //   Get.offNamed(GetPageRoutes.login);
    // } else {
    Get.offNamed(GetPageRoutes.login);
    // }
  }
}
