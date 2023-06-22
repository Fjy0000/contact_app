import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/viewModel/edit_contact_viewmodel.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/permission_util.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_avatar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final viewModel = Get.createViewModel(EditContactViewModel());

  String? avatarPath;

  XFile? image;
  final ImagePicker picker = ImagePicker();

  bool? isChangePicture = false;

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

      avatarPath = image?.path ?? arguments.contact?.imagePath;
      if (image?.path.isNotEmpty == true) {
        isChangePicture = true;
      } else {
        isChangePicture = false;
      }
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    nameController.text = arguments.contact?.name ?? "";
    contactNoController.text = arguments.contact?.contactNo ?? "";
    emailController.text = arguments.contact?.email ?? "";
    organisationController.text = arguments.contact?.organisation ?? "";
    addressController.text = arguments.contact?.address ?? "";
    noteController.text = arguments.contact?.note ?? "";
    avatarPath = arguments.contact?.imagePath ?? "";

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void update() {
    if (contactNoController.text.isEmpty) {
      showToast('input_contactNo_error'.tr);
    } else {
      viewModel.editContact(
        isChangePicture,
        ContactBean(
          id: arguments.contact?.id,
          name: nameController.text,
          contactNo: contactNoController.text,
          email: emailController.text,
          organisation: organisationController.text,
          address: addressController.text,
          note: noteController.text,
          imagePath: avatarPath,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar("update_contact_details".tr),
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
                      Stack(
                        children: [
                          BaseAvatar(
                            imagePath: avatarPath,
                            isImagePath: isChangePicture,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
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
                        label: "name".tr,
                        controller: nameController,
                        removeDecoration: true,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "contact_no".tr,
                        controller: contactNoController,
                        removeDecoration: true,
                        keyboardType: TextInputType.phone,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "email".tr,
                        controller: emailController,
                        removeDecoration: true,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 20,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "organisation".tr,
                        controller: organisationController,
                        removeDecoration: true,
                        maxLength: 40,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "address".tr,
                        controller: addressController,
                        removeDecoration: true,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "note".tr,
                        controller: noteController,
                        removeDecoration: true,
                        keyboardType: TextInputType.phone,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
              BaseButton(
                'update'.tr,
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  update();
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
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Color(0xff282d3f),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseText(
            'choose_profile_photo'.tr,
            fontSize: 24,
          ),
          const SizedBox(height: 40),
          BaseButton(
            "camera".tr,
            onPressed: () {
              getSource('camera');
            },
            color: Color(0x33ffffff),
            margin: const EdgeInsets.symmetric(horizontal: 40),
          ),
          const SizedBox(height: 15),
          BaseButton(
            "gallery".tr,
            onPressed: () {
              getSource('gallery');
            },
            color: Color(0x33ffffff),
            margin: const EdgeInsets.symmetric(horizontal: 40),
          ),
        ],
      ),
    );
  }
}
