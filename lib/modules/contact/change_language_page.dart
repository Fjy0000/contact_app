import 'package:app2/base/base_event_bus.dart';
import 'package:app2/base/localization_service.dart';
import 'package:app2/main.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/utils/constants/enums.dart';
import 'package:app2/widgets/base_app_bar.dart';
import 'package:app2/widgets/base_divider.dart';
import 'package:app2/widgets/base_scaffold.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  RxString langCode = RxString(LocalizationService.getLanguage().languageCode);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: BaseAppBar(
          'lang'.tr,
        ),
        body: SafeArea(
          child: Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  _langRow('English', LangType.EN, 'en'),
                  _langRow('简体中文', LangType.CN, 'zh'),
                ],
              ),
            );
          }),
        ));
  }

  Widget _langRow(String title, LangType langType, String languageCode) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        changeLangCode(languageCode, langType);
      },
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BaseText(
                    title,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    //letterSpacing: 0.11,
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xff08060B)),
                  child: Radio(
                    activeColor: AppTheme.BLUE,
                    value: languageCode,
                    groupValue: langCode.value,
                    onChanged: (value) {
                      changeLangCode(languageCode, langType);
                    },
                  ),
                ),
              ],
            ),
            BaseDivider(),
          ],
        ),
      ),
    );
  }

  void changeLangCode(String languageCode, LangType langType) {
    LocalizationService.setLanguage(langType);
    langCode.value = LocalizationService.getLanguage().languageCode;
    eventBus?.fire(BaseEventBus(EventBusAction.CHANGE_LANGUAGE));
    // viewModel.changeLanguage(
    //   languageCode,
    //   onSuccess: (value) {
    //     LocalizationService.setLanguage(langType);
    //     langCode.value = LocalizationService.getLanguage().languageCode;
    //     eventBus?.fire(BaseEventBus(EventBusAction.CHNAGE_LANGUAGE));
    //   },
    // );
  }
}
