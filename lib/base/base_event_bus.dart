import 'package:app2/utils/constants/enums.dart';

class BaseEventBus {
  dynamic data;

  EventBusAction type;

  BaseEventBus(this.type, {this.data});
}
