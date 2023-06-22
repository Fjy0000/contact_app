import 'dart:async';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/argument/contact_details_argument.dart';
import 'package:app2/modules/contact/viewModel/read_contact_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/extension.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_state_ui.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/base_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final viewModel = Get.createViewModel(ReadContactViewModel());

  StreamSubscription? subscription;

  @override
  void initState() {
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

  void initApi() {
    viewModel.getData();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void _refresh() {
    initApi();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        "contact".tr,
        isEnableBack: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(GetPageRoutes.addContact);
            },
            icon: const Icon(
              Icons.add,
              color: AppTheme.WHITE_COLOR,
            ),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.compare_arrows,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text("change_lang".tr),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text("logout".tr),
                  ],
                ),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Get.toNamed(GetPageRoutes.changeLanguage);
            } else if (value == 1) {
              Get.offNamed(GetPageRoutes.login);
            }
          }),
        ],
      ),
      body: Obx(
        () {
          if (viewModel.appState.value != AppState.Success) {
            return BaseAppStateUi(viewModel.appState, onPressed: () {
              _refresh();
            });
          }
          return SafeArea(
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                _refresh();
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 15),
                itemCount: viewModel.contactList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 25),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      if (index == 0) const SizedBox(height: 10),
                      item(viewModel.contactList[index]),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget item(ContactBean data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(GetPageRoutes.contactDetails,
            arguments: ContactArgument(data));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            BaseAvatar(
              width: 60,
              height: 60,
              iconPaddingAll: 15,
              imagePath: data.imagePath,
            ),
            const SizedBox(width: 20),
            data.name != ''
                ? BaseText(data.name, fontSize: 18)
                : BaseText(data.contactNo, fontSize: 18),
          ],
        ),
      ),
    );
  }
}
