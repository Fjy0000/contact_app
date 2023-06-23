import 'dart:async';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/main.dart';
import 'package:app2/model/base_menu_item.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/argument/contact_details_argument.dart';
import 'package:app2/modules/contact/viewModel/read_contact_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/utils/image_utils.dart';
import 'package:app2/utils/permission_util.dart';
import 'package:app2/widgets/base_avatar.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  ContactArgument arguments = Get.arguments;

  final viewModel = Get.createViewModel(ReadContactViewModel());

  StreamSubscription? subscription;

  List<BaseMenuItem> bottomBarItem = [];

  @override
  void initState() {
    initBottomBarItem();
    super.initState();

    initApi();

    subscription = eventBus?.on<BaseEventBus>().listen((event) {
      switch (event.type) {
        case EventBusAction.REFRESH_CONTACT:
          initApi();
          break;
        default:
          break;
      }
    });
  }

  initApi() {
    viewModel.selectedContactDetails(arguments.contact?.id);
  }

  initBottomBarItem() {
    bottomBarItem.clear();
    bottomBarItem.addAll([
      BaseMenuItem(
          label: "edit".tr,
          icon: "edit_btn.svg",
          onTap: () {
            Get.toNamed(
              GetPageRoutes.editContact,
              arguments: ContactArgument(viewModel.response.value),
            );
          }),
    ]);
  }

  Future<void> requestPhoneCall(ContactBean? data) async {
    requestPermission([Permission.phone],
        customMsg: 'permission_required_phone'.tr, onSuccess: (value) async {
      if (value.isGranted) {
        final Uri phone = Uri(
          scheme: 'tel',
          path: data?.contactNo,
        );
        var url = phone.toString();
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw '${'cannot_launch'.tr} $url';
        }
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Obx(() {
        var data = viewModel.response.value;

        return NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: BaseText(
                    "contact_details".tr,
                    fontSize: 20,
                  ),
                  centerTitle: true,
                  pinned: true,
                  expandedHeight:
                      MediaQuery.of(context).size.height * 0.3 + kToolbarHeight,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(GetPageRoutes.contactQr,
                            arguments: ContactArgument(data));
                      },
                      icon: const Icon(
                        Icons.qr_code,
                        color: AppTheme.WHITE_COLOR,
                      ),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: buildHeader(data),
                    collapseMode: CollapseMode.pin,
                  ),
                ),
              ),
            ];
          },
          body: buildBody(data),
        );
      }),
    );
  }

  Widget buildBody(ContactBean? data) {
    return LayoutBuilder(builder: (context, constraint) {
      //enforce a maximum height constraint on its child widget
      return ConstrainedBox(
        //which ensures that the child widget does not exceed the available height
        constraints: BoxConstraints(maxHeight: constraint.minHeight),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        buildRowText(
                          "contact_no".tr,
                          data?.contactNo,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "name".tr,
                          data?.name,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "organisation".tr,
                          data?.organisation,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "email".tr,
                          data?.email,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "address".tr,
                          data?.address,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "note".tr,
                          data?.note,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: AppTheme.DARK_PURPLE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (BaseMenuItem item in bottomBarItem)
                    buildBottomBarItem(item),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget buildRowText(String? label, String? data) {
    return Row(
      children: [
        BaseText(
          "$label :",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BaseText(
            data,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget buildHeader(ContactBean? data) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
          color: const Color(0x26ffffff).withOpacity(0.17)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseAvatar(
            imagePath: data?.imagePath,
          ),
          const SizedBox(height: 15),
          BaseText(
            data?.name,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  requestPhoneCall(data);
                },
                icon: const Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () async {
                  if (data?.email != '') {
                    final Uri email = Uri(
                      scheme: 'mailto',
                      path: data?.email,
                    );
                    var url = email.toString();
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw '${'cannot_launch'.tr} $url';
                    }
                  } else {
                    showToast('${'not_found_email'.tr} !!!');
                  }
                },
                icon: const Icon(
                  Icons.chat,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBottomBarItem(BaseMenuItem item) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: item.onTap,
          child: Column(
            children: [
              imageAsset(
                  res: item.icon,
                  width: 20,
                  height: 20,
                  color: AppTheme.WHITE_COLOR),
              const SizedBox(height: 5),
              BaseText(item.label),
            ],
          ),
        ),
      ),
    );
  }
}
