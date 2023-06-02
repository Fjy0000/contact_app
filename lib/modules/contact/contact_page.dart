import 'dart:async';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/main.dart';
import 'package:app2/model/body/contact_body.dart';
import 'package:app2/modules/contact/argument/contact_details_argument.dart';
import 'package:app2/modules/contact/viewModel/read_contact_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_state_ui.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final viewModel = ReadContactViewModel();

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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.toNamed(GetPageRoutes.addContact);
              },
              icon: const Icon(
                Icons.add,
                color: AppTheme.WHITE_COLOR,
              ),
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
          return buildList();
        },
      ),
    );
  }

  Widget buildList() {
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
  }

  Widget item(Contact data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(GetPageRoutes.contactDetails,
            arguments: ContactArgument(data));
      },
      onLongPressStart: (LongPressStartDetails details) {
        showPopUpMenu(context, details.globalPosition);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(right: 20),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppTheme.BLUE),
              child: BaseText(
                data.name?.substring(0, 1).toUpperCase(),
                fontSize: 18,
                color: AppTheme.BLACK24,
              ),
            ),
            BaseText(data.name, fontSize: 18),
          ],
        ),
      ),
    );
  }

  void showPopUpMenu(BuildContext context, Offset position) {
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
        handleMenuItemSelection(value);
      }
    });
  }

  void handleMenuItemSelection(int value) {
    switch (value) {
      case 1:
        print('Option 1 selected');
        break;
      default:
        break;
    }
  }
}
