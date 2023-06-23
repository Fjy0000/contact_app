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
import 'package:flutter_slidable/flutter_slidable.dart';
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
                    const Icon(
                      Icons.compare_arrows,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text("change_lang".tr),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text("logout".tr),
                  ],
                ),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Get.toNamed(GetPageRoutes.changeLanguage);
            } else if (value == 1) {
              box.remove(StoreBox.USER_LOGIN);
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
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: 1 / 4,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            backgroundColor: AppTheme.RED,
            autoClose: false,
            onPressed: (BuildContext context) {
              deleteDialog(data);
              setState(() {
                Slidable.of(context)?.close();
              });
            },
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: BaseText(
              'delete'.tr,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
      child: GestureDetector(
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
      ),
    );
  }

  Future<void> deleteDialog(ContactBean data) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.BG_COLOR,
          title: BaseText(
            "delete_title".tr,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          content: RichText(
            text: TextSpan(
              text: '${'delete_desc'.tr} : ( ',
              children: <TextSpan>[
                TextSpan(
                  text: data.name?.isNotEmpty == true
                      ? data.name
                      : data.contactNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const TextSpan(text: ' ) ?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: BaseText(
                'cancel'.tr,
                color: AppTheme.HINT,
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteContact(data);
              },
              child: BaseText(
                'delete'.tr,
                color: AppTheme.RED,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }
}
