import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/viewModel/create_contact_viewmodel.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/permission_util.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_avatar.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/custom_textfield.dart';
import 'package:country_code_picker/country_code_picker.dart';
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

  final viewModel = Get.createViewModel(CreateContactViewModel());

  final _countryKey = GlobalKey<CountryCodePickerState>();

  String avatarPath = '';

  String _countryCode = '+60';

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
          customMsg: 'permission_required_storage'.tr, onSuccess: (value) {
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
      avatarPath = image?.path ?? '';
      Navigator.pop(context);
    });
  }

  void save() {
    final fullContactNo = "$_countryCode ${contactNoController.text}";

    if (emailController.text != '') {
      if (!emailController.text.contains("@") &&
          !emailController.text.contains(".com")) {
        showToast("input_email_error".tr);
      }
    } else if (contactNoController.text.isEmpty) {
      showToast('input_contactNo_error'.tr);
    } else if (fullContactNo.length < 11) {
      showToast('input_contactNo_error2'.tr);
    } else {
      viewModel.saveContact(
        ContactBean(
          name: nameController.text,
          contactNo: fullContactNo,
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
      appBar: BaseAppBar("add_new_contact".tr),
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
                          BaseAvatar(
                            isImagePath: true,
                            imagePath: avatarPath,
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
                        maxLength: 12,
                        paddingPrefix: EdgeInsets.zero,
                        prefix: Column(
                          children: [
                            CountryCodePicker(
                              key: _countryKey,
                              onChanged: (country) {
                                setState(() {
                                  _countryCode = country.dialCode!;
                                });
                              },
                              initialSelection: '+60',
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
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
                        maxLength: 30,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "address".tr,
                        controller: addressController,
                        removeDecoration: true,
                        maxLines: 8,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "note".tr,
                        controller: noteController,
                        removeDecoration: true,
                        maxLines: 8,
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
              BaseButton(
                'save'.tr,
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  save();
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
