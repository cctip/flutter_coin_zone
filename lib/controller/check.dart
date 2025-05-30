import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import '/controller/user.dart';

var formater = DateFormat('yyyy-MM-dd');

class CheckController extends GetxController {
  static final weekSignedTimes = [].obs; // 本周已签到日期
  static final isSignedToday = false.obs; // 今日是否已签到
  static final signedCstTimes = 0.obs; // 连续签到天数

  // 初始化签到信息
  static init() {
    signedCstTimes.value = SharePref.getInt('signedCstTimes') ?? 0;

    DateTime now = DateTime.now();
    int curYear = now.year; // 今年
    int curMonth = now.month; // 当月
    int curDay = now.day; // 今日
    int weekday = now.weekday; // 今天是本周的第几天

    String today = formater.format(now); // 今天
    String yestoday = formater.format(DateTime(curYear, curMonth, curDay - 1)); // 昨天
    String timeMonday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 1)); // 周一
    String timeTuesday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 2)); // 周二
    String timeWednesday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 3)); // 周三
    String timeThursday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 4)); // 周四
    String timeFriday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 5)); // 周五
    String timeSaturday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 6)); // 周六
    String timeSunday = formater.format(DateTime(curYear, curMonth, curDay - weekday + 7)); // 周日

    weekSignedTimes.value = [];
    List<String> historyTimes = SharePref.getStringList('sign_times') ?? [];
    if (!historyTimes.contains(yestoday)) signedCstTimes.value = historyTimes.contains(today) ? 1 : 0; // 昨天没有签到
    if (historyTimes.contains(today)) isSignedToday.value = true; // 今天已签到
    if (historyTimes.contains(timeMonday)) weekSignedTimes.add('1');
    if (historyTimes.contains(timeTuesday)) weekSignedTimes.add('2');
    if (historyTimes.contains(timeWednesday)) weekSignedTimes.add('3');
    if (historyTimes.contains(timeThursday)) weekSignedTimes.add('4');
    if (historyTimes.contains(timeFriday)) weekSignedTimes.add('5');
    if (historyTimes.contains(timeSaturday)) weekSignedTimes.add('6');
    if (historyTimes.contains(timeSunday)) weekSignedTimes.add('7');
  }

  // 今日签到
  static onSignToday() {
    DateTime now = DateTime.now();
    String today = formater.format(now);
    List<String> historyTimes = SharePref.getStringList('sign_times') ?? [];
    if (!historyTimes.contains(today)) {
      SharePref.setInt('signedCstTimes', signedCstTimes.value + 1);
      SharePref.setStringList('sign_times', [...historyTimes, today]);
      UserController.increasePoint(10);
      init();
    }
  }
}