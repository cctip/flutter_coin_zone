import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static String avator = 'assets/images/avator/1.png';
  static final level = RxInt(1);
  static final exp = RxInt(0);
  static final points = RxInt(0);
  static final freeSpined = RxBool(false); // 免费抽奖已使用
  static final freeSpinTime = RxString(''); // 上次免费抽奖时间

  // 初始化
  static init() {
    points.value = SharePref.getInt('points') ?? 0;
    level.value = SharePref.getInt('level') ?? 1;
    exp.value = SharePref.getInt('exp') ?? 0;
    freeSpinTime.value = SharePref.getString('freeSpinTime') ?? '';
    if (freeSpinTime.value != '') {
      freeSpined.value = freeSpinTime.value == formater.format(DateTime.now());
    }
  }

  // 增加小星星点数
  static increasePoint(int value) {
    points.value += value;
    SharePref.setInt('points', points.value);
  }
  // 减少小星星点数
  static decreasePoint(int value) {
    points.value -= value;
    SharePref.setInt('points', points.value);
  }
  // 增加经验
  static increaseExp(int value) {
    level.value += (exp.value + value) ~/ 200;
    exp.value = (exp.value + value) % 200;
    SharePref.setInt('exp', exp.value);
    SharePref.setInt('level', level.value);
  }
  // 免费抽奖
  static onFreeSpin() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    freeSpined.value = true;
    SharePref.setString('freeSpinTime', today);
  }
}