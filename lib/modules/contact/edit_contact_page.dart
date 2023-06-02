import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/viewModel/edit_contact_viewmodel.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'argument/contact_details_argument.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({Key? key}) : super(key: key);

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  ContactArgument arguments = Get.arguments;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController organisationController = TextEditingController();

  final viewModel = EditContactViewModel();

  @override
  void initState() {
    nameController.text = arguments.contact?.name ?? "";
    contactNoController.text = arguments.contact?.contactNo ?? "";
    emailController.text = arguments.contact?.email ?? "";
    organisationController.text = arguments.contact?.organisation ?? "";
    addressController.text = arguments.contact?.address ?? "";
    noteController.text = arguments.contact?.note ?? "";

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar("Update Contact Details"),
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
                        controller: nameController,
                        removeDecoration: true,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Contact No",
                        controller: contactNoController,
                        removeDecoration: true,
                        keyboardType: TextInputType.phone,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        removeDecoration: true,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Organisation",
                        controller: organisationController,
                        removeDecoration: true,
                        keyboardType: TextInputType.phone,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Address",
                        controller: addressController,
                        removeDecoration: true,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Note",
                        controller: noteController,
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
                'Update',
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                onPressed: () {
                  if (contactNoController.text.isEmpty) {
                    showToast('Required fill up contact no');
                  } else {
                    viewModel.editContact(
                      Contact(
                        name: nameController.text,
                        contactNo: contactNoController.text,
                        email: emailController.text,
                        organisation: organisationController.text,
                        address: addressController.text,
                        note: noteController.text,
                        id: arguments.contact?.id,
                      ),
                    );
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
