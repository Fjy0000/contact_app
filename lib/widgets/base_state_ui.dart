import 'package:app2/base/base_viewmodel.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:app2/widgets/base_button.dart';
import 'package:app2/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseAppStateUi extends StatelessWidget {
  final Rx<AppState>? appState;
  final Widget? customLoading;
  final VoidCallback? onPressed;

  const BaseAppStateUi(
    this.appState, {
    Key? key,
    this.customLoading,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (appState?.value == AppState.Loading) {
      return Container(
        child: customLoading ??
            const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            ),
      );
    } else if (appState?.value == AppState.Empty) {
      return emptyUi();
    } else if (appState?.value == AppState.Failed) {
      return failedUi();
    } else if (appState?.value == AppState.ComingSoon) {
      return comingSoonUi();
    }

    return const Center(
      child: BaseText('No app state specified ! !'),
    );
  }

  Widget emptyUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_pic.png'),
          const SizedBox(height: 20),
          BaseText('no_result_found'.tr, fontSize: 16),
          BaseText('nothing_now'.tr, fontSize: 14, color: AppTheme.HINT),
          const SizedBox(height: 20),
          BaseButton(
            'Refresh',
            margin: const EdgeInsets.symmetric(horizontal: 35),
            textSize: 12,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Widget failedUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BaseText(
            'Failed',
            fontSize: 24,
          ),
          const SizedBox(
            height: 20,
          ),
          BaseButton(
            'Retry',
            textSize: 16,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Widget comingSoonUi() {
    return const Center(
      child: BaseText('Coming Soon'),
    );
  }
}
