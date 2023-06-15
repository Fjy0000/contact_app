import 'dart:async';

import 'package:app2/base/base_event_bus.dart';
import 'package:app2/main.dart';
import 'package:app2/model/base_menu_item.dart';
import 'package:app2/modules/contact/argument/contact_details_argument.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/utils/get_page_router.dart';
import 'package:app2/utils/image_utils.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:app2/widgets/base_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  ContactArgument arguments = Get.arguments;

  StreamSubscription? subscription;

  List<BaseMenuItem> bottomBarItem = [];

  @override
  void initState() {
    initBottomBarItem();
    super.initState();

    subscription = eventBus?.on<BaseEventBus>().listen((event) {
      switch (event.type) {
        case EventBusAction.REFRESH_CONTACT:
          break;
        default:
          break;
      }
    });
  }

  initBottomBarItem() {
    bottomBarItem.clear();
    bottomBarItem.addAll([
      //BaseMenuItem(label: "Favourite", icon: "star_btn.svg", onTap: () {}),
      BaseMenuItem(
          label: "Edit",
          icon: "edit_btn.svg",
          onTap: () {
            Get.toNamed(
              GetPageRoutes.editContact,
              arguments: ContactArgument(arguments.contact),
            );
          }),
      //BaseMenuItem(label: "Menu", icon: "menu_btn.svg", onTap: () {})
    ]);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: Colors.transparent,
                title: const BaseText(
                  "Contact Details",
                  fontSize: 20,
                ),
                centerTitle: true,
                pinned: true,
                expandedHeight:
                    MediaQuery.of(context).size.height * 0.3 + kToolbarHeight,
                forceElevated: innerBoxIsScrolled,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.qr_code,
                      color: AppTheme.WHITE_COLOR,
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: buildHeader(),
                  collapseMode: CollapseMode.pin,
                ),
              ),
            ),
          ];
        },
        body: buildBody(),
      ),
    );
  }

  Widget buildBody(){
    return LayoutBuilder(builder: (context, constraint) {
      return ConstrainedBox(
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
                          "Contact No",
                          arguments.contact?.contactNo,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "Name",
                          arguments.contact?.name,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "Organisation",
                          arguments.contact?.organisation,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "Email",
                          arguments.contact?.email,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "Address",
                          arguments.contact?.address,
                        ),
                        const SizedBox(height: 20),
                        buildRowText(
                          "Note",
                          arguments.contact?.note,
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
                  for (BaseMenuItem item in bottomBarItem) buildItem(item),
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

  Widget buildHeader() {
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
            isImageUrl: true,
            imagePath: arguments.contact?.imagePath,
          ),
          const SizedBox(height: 15),
          BaseText(
            arguments.contact?.name,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
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

  Widget buildItem(BaseMenuItem item) {
    return Container(
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
    );
  }
}
