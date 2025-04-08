import 'package:get/get.dart';

class CreateController extends GetxController {
  static final widgetCount = 0.obs;
  static final focusNodeKey = ''.obs;

  static incWidget() { widgetCount.value++; }
  static decWidget() { widgetCount.value--; }
  static clearWidget() { widgetCount.value = 0; }

  // 聚焦
  static onFocus(key) {
    focusNodeKey.value = key;
  }
  // 失去焦点
  static cancelFocus() {
    focusNodeKey.value = '';
  }
}