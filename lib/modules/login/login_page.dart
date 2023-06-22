import 'package:app2/base/localization_service.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/utils/image_utils.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
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
    if (isAgree != true) {
      showToast("login_error_3".tr);
    } else if (email.text.isEmpty || password.text.isEmpty) {
      showToast("login_error_1".tr);
      return;
    } else if (email.text != "abc@gmail.com" || password.text != "123456") {
      showToast("${"login_error_2".tr} !!!");
      return;
    } else {
      Get.offNamed(GetPageRoutes.contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        'login'.tr,
        isEnableBack: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(GetPageRoutes.changeLanguage);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0x33e8e8e8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: BaseText(
                      LocalizationService.getStoreLanguage() == LangType.EN
                          ? "EN"
                          : "中文"),
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  BaseTextField(
                    hinText: 'email_hint'.tr,
                    controller: email,
                    baseFontWeight: FontWeight.bold,
                    baseText: 'email'.tr,
                    isDisable: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BaseTextField(
                    hinText: 'password_hint'.tr,
                    controller: password,
                    obscureText: isObscure.value,
                    baseFontWeight: FontWeight.bold,
                    baseText: 'password'.tr,
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
                    'login'.tr,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
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
              text: 'agreement_desc'.tr,
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
                  text: "user_agreement".tr,
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
