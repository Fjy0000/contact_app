import 'package:get/get.dart';

enum AppState {
  Loading,
  Success,
  ComingSoon,
  Empty,
  Failed,
}

abstract class BaseViewModel extends GetxController {
  Rx<AppState> appState = AppState.Loading.obs;
}
