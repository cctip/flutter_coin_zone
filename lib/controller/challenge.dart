import 'package:get/get.dart';
import '/common/share_pref.dart';
import '/controller/user.dart';

class ChallengeController extends GetxController {
  static final predict3 = false.obs; // 预测3次
  static final predictCst2 = false.obs; // 连续预测2天
  static final checkedCst3 = false.obs; // 连续签到3天
  static final checkedCst7 = false.obs; // 连续签到7天
  static final predictCst7 = false.obs; // 连续预测7天
  static final successPrt10 = false.obs; // 成功预测10次
  static final successPrt30 = false.obs; // 成功预测30次
  static final successPrt50 = false.obs; // 成功预测50次

  // 初始化
  static init() {
    predict3.value = SharePref.getBool('predict3') ?? false;
    predictCst2.value = SharePref.getBool('predictCst2') ?? false;
    checkedCst3.value = SharePref.getBool('checkedCst3') ?? false;
    checkedCst7.value = SharePref.getBool('checkedCst7') ?? false;
    predictCst7.value = SharePref.getBool('predictCst7') ?? false;
    successPrt10.value = SharePref.getBool('successPrt10') ?? false;
    successPrt30.value = SharePref.getBool('successPrt30') ?? false;
    successPrt50.value = SharePref.getBool('successPrt50') ?? false;
  }

  // 预测3次
  static claimPredict3() {
    SharePref.setBool('predict3', true);
    predict3.value = true;
    UserController.increaseExp(20);
  }
  // 连续预测2天
  static claimPredictCst2() {
    SharePref.setBool('predictCst2', true);
    predictCst2.value = true;
    UserController.increaseExp(50);
  }
  // 连续签到3天
  static claimCheckedCst3() {
    SharePref.setBool('checkedCst3', true);
    checkedCst3.value = true;
    UserController.increaseExp(80);
  }
  // 连续签到7天
  static claimCheckedCst7() {
    SharePref.setBool('checkedCst7', true);
    checkedCst7.value = true;
    UserController.increaseExp(100);
  }
  // 连续预测7天
  static claimPredictCst7() {
    SharePref.setBool('predictCst7', true);
    predictCst7.value = true;
    UserController.increaseExp(200);
  }
  // 成功预测10次
  static claimSuccessPrt10() {
    SharePref.setBool('successPrt10', true);
    successPrt10.value = true;
    UserController.increaseExp(300);
  }
  // 成功预测30次
  static claimSuccessPrt30() {
    SharePref.setBool('successPrt30', true);
    successPrt30.value = true;
    UserController.increaseExp(900);
  }
  // 成功预测50次
  static claimSuccessPrt50() {
    SharePref.setBool('successPrt50', true);
    successPrt50.value = true;
    UserController.increaseExp(2000);
  }
}