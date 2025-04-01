import 'package:flutter_coin_zone/common/share_pref.dart';
import 'package:get/get.dart';

class ChallengeController extends GetxController {
  static final predictTimes = RxInt(0);

  // 初始化
  static init() {
    predictTimes.value = SharePref.getInt(predictTimes) ?? 0;
  }
}