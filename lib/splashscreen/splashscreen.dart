import 'dart:async';

import 'package:app2/main.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/get_page_router.dart';
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
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Icon(
            Icons.abc,
            size: 150,
            color: Colors.black,
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
    Get.offNamed(GetPageRoutes.contact);
    // }
  }
}
