import 'dart:async';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/argument/contact_details_argument.dart';
import 'package:app2/modules/contact/viewModel/delete_contact_viewmodel.dart';
import 'package:app2/modules/contact/viewModel/read_contact_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
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
  final viewModel = ReadContactViewModel();
  final deleteViewModel = DeleteContactViewModel();

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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        "Contact",
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
          IconButton(
            onPressed: () {
              Get.offNamed(GetPageRoutes.login);
            },
            icon: const Icon(
              Icons.logout,
              color: AppTheme.WHITE_COLOR,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (viewModel.appState.value != AppState.Success) {
            return BaseAppStateUi(viewModel.appState, onPressed: () {
              initState();
            });
          }
          return SafeArea(
            child: ListView.separated(
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
          );
        },
      ),
    );
  }

  Widget item(Contact data) {
    print("@@@@@@@ ${data.imagePath}");
    return GestureDetector(
      onTap: () {
        Get.toNamed(GetPageRoutes.contactDetails,
            arguments: ContactArgument(data));
      },
      onLongPressStart: (LongPressStartDetails details) {
        showPopUpMenu(context, details.globalPosition, data);
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
              isImageUrl: true,
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

  void showPopUpMenu(BuildContext context, Offset position, Contact data) {
    //menu display position
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RenderBox widgetBox = context.findRenderObject() as RenderBox;
    final Offset widgetPosition = widgetBox.localToGlobal(Offset.zero);
    final double dx = position.dx - widgetPosition.dx;
    final double dy = position.dy - widgetPosition.dy;
    final Offset popupPosition = Offset(dx, dy);

    List<PopupMenuEntry> menuItems = [
      const PopupMenuItem(
        value: 1,
        child: Text('Delete'),
      ),
    ];

    showMenu(
      context: context,
      position: RelativeRect.fromSize(
        Rect.fromPoints(popupPosition, popupPosition),
        overlay.size,
      ),
      items: menuItems,
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        showMenuItemDialog(value, data);
      }
    });
  }

  void showMenuItemDialog(int value, Contact data) {
    switch (value) {
      case 1:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppTheme.BG_COLOR,
                title: const BaseText(
                  "Delete Contact",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                content: RichText(
                  text: TextSpan(
                    text: 'Do you want to delete this contact : (',
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
                      const TextSpan(text: ') ?'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const BaseText(
                      'Cancel',
                      color: AppTheme.HINT,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      deleteViewModel.deleteContact(data);
                    },
                    child: const BaseText(
                      'Delete',
                      color: AppTheme.RED,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            });
        break;
      default:
        break;
    }
  }
}
