import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var formater = DateFormat('yyyy-MM-dd');

class Global {
  static late SharedPreferences _prefs;
  static String avator = 'assets/images/avator/1.png';
  static int starCount = 0;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
  }

  static Object getter = {
  };
  static Object setter = {
    // 设置头像
    'setAvator': (value) {
      avator = value;
      _prefs.setString('avator', value);
    }
  };

  // 今日签到
  static checkToday() {
    starCount++;
  }

  // 清理数据
  static clear() {
    _prefs.clear();
  }
}