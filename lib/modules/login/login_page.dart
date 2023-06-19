import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/utils/image_utils.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isAgree = false;

  RxBool isObscure = true.obs;

  @override
  void initState() {
    email.text = "abc@gmail.com";
    password.text = "123456";

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showAgreement() async {
    const url = "https://www.google.com.my/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  void login() {
    if (email.text.isEmpty || password.text.isEmpty) {
      showToast("Please fill in all fields");
      return;
    } else if (email.text != "abc@gmail.com" || password.text != "123456") {
      showToast("email or password wrong !!!");
      return;
    } else {
      Get.offNamed(GetPageRoutes.contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar('Login'),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  BaseTextField(
                    hinText: 'Enter email'.tr,
                    controller: email,
                    baseFontWeight: FontWeight.bold,
                    baseText: 'Email'.tr,
                    isDisable: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BaseTextField(
                    hinText: 'Enter password'.tr,
                    controller: password,
                    obscureText: isObscure.value,
                    baseFontWeight: FontWeight.bold,
                    baseText: 'Password'.tr,
                    isDisable: true,
                    postfix: obscureBtn(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildAgreementSection(),
                  const SizedBox(
                    height: 47,
                  ),
                  BaseButton(
                    'Login',
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {
                      login();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildAgreementSection() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
          value: isAgree,
          onChanged: (bool? value) {
            setState(() {
              isAgree = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I confirm that I have read, understood and agree',
              style: const TextStyle(
                color: AppTheme.WHITE_COLOR,
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.40,
              ),
              children: [
                const TextSpan(text: '  '),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => {
                          showAgreement(),
                        },
                  text: "User Agreement",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.40,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget obscureBtn() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        isObscure.value = !isObscure.value;
      },
      child: Container(
        child: isObscure.value == false
            ? imageAsset(
                res: 'eye.svg',
                width: 28,
                height: 28,
                color: Colors.deepPurple,
              )
            : imageAsset(
                res: 'eye_off.svg',
                width: 28,
                height: 28,
                color: Colors.deepPurple,
              ),
      ),
    );
  }
}
