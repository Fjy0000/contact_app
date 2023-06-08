import 'dart:io';

import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/viewModel/create_contact_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/image_utils.dart';
import 'package:app2/utils/permission_util.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController organisationController = TextEditingController();

  String? avatarController;

  final viewModel = CreateContactViewModel();

  XFile? image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> getSource(String type) async {
    if (type == 'camera') {
      requestPermission([Permission.camera],
          customMsg: 'permission_required_camera'.tr, onSuccess: (value) {
        if (value.isGranted) {
          getPhoto(ImageSource.camera);
        }
      });
    } else if (type == 'gallery') {
      requestPermission([Permission.storage],
          customMsg: 'permission_required_camera'.tr, onSuccess: (value) {
        if (value.isGranted) {
          getPhoto(ImageSource.gallery);
        }
      });
    }
  }

  void getPhoto(ImageSource source) async {
    final pickImage = await picker.pickImage(source: source);
    setState(() {
      image = pickImage;

      avatarController = image?.path ?? "";

      Navigator.pop(context);
    });
  }

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 35),
                      Stack(
                        children: [
                          ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.purple),
                              child: image != null
                                  ? Image.file(
                                      File(image?.path ?? ''),
                                      fit: BoxFit.fill,
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 35,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.transparent,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                'Save',
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                onPressed: () {
                  if (contactNoController.text.isEmpty) {
                    showToast('Required fill up CONTACT NO');
                  } else {
                    viewModel.saveContact(
                      Contact(
                        name: nameController.text,
                        contactNo: contactNoController.text,
                        email: emailController.text,
                        organisation: organisationController.text,
                        address: addressController.text,
                        note: noteController.text,
                        imagePath: avatarController,
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

  Widget bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Color(0xff6750a4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BaseText(
            'Choose Profile Photo',
            fontSize: 24,
            color: AppTheme.BLACK24,
          ),
          const SizedBox(height: 40),
          BaseButton(
            "Camera",
            onPressed: () {
              getSource('camera');
            },
            textColor: AppTheme.BLACK24,
            color: Colors.white.withOpacity(0.4),
            margin: const EdgeInsets.symmetric(horizontal: 60),
          ),
          const SizedBox(height: 15),
          BaseButton(
            "Gallery",
            onPressed: () {
              getSource('gallery');
            },
            textColor: AppTheme.BLACK24,
            color: Colors.white.withOpacity(0.4),
            margin: const EdgeInsets.symmetric(horizontal: 60),
          ),
        ],
      ),
    );
  }
}
