import 'package:flutter_coin_zone/common/share_pref.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static String avator = 'assets/images/avator/1.png';
  static final level = RxInt(1);
  static final exp = RxInt(0);
  static final points = RxInt(0);

  // 初始化
  static init() {
    points.value = SharePref.getInt('points') ?? 0;
    level.value = SharePref.getInt('level') ?? 0;
    exp.value = SharePref.getInt('exp') ?? 0;
  }

  // 增加小星星点数
  static increasePoint(int value) {
    points.value += value;
    SharePref.setInt('points', points.value);
  }
  // 增加经验
  static increaseExp(int value) {
    level.value += (exp.value + value) ~/ 200;
    exp.value = (exp.value + value) % 200;
    SharePref.setInt('exp', exp.value);
    SharePref.setInt('level', level.value);
  }
}