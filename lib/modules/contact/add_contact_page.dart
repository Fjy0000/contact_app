import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/viewModel/create_contact_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController name = TextEditingController();
  TextEditingController contactNo = TextEditingController();

  final viewModel = CreateContactViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar("Add New Contact"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      CustomTextField(
                        label: "Name",
                        controller: name,
                        hintText: "Enter the full name",
                        removeDecoration: true,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Contact No",
                        controller: contactNo,
                        hintText: "Enter the contact no",
                        removeDecoration: true,
                        keyboardType: TextInputType.phone,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
              BaseButton(
                'Save',
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                onPressed: () {
                  if (name.text.isEmpty || contactNo.text.isEmpty) {
                    showToast('Required fill up all field');
                  } else {
                    viewModel.saveContact(
                        Contact(name: name.text, contactNo: contactNo.text));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
