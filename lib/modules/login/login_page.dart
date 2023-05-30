import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar('Login'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 35),
              textField("Username", "enter your username", username),
              const SizedBox(height: 20),
              textField("Password", "enter your password", password),
              const SizedBox(height: 35),
              BaseButton(
                'Login',
                margin: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () {
                  Get.offNamed(GetPageRoutes.contact);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(
      String name, String hintText, TextEditingController controller) {
    return CustomTextField(
      label: name,
      controller: controller,
      hintText: hintText,
      removeDecoration: true,
    );
  }
}
