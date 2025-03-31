import 'package:flutter_coin_zone/common/share_pref.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static String avator = 'assets/images/avator/1.png';
  static int level = 0;
  static int exp = 0;
  static final points = RxInt(0);

  // 初始化
  static init() {
    points.value = SharePref.getInt('points') ?? 0;
  }

  static increment() {
    points.value++;
    SharePref.setInt('points', points.value);
  }
  static increasePoint(int value) {
    points.value += value;
    SharePref.setInt('points', points.value);
  }
}