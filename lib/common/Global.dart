import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var formater = DateFormat('yyyy-MM-dd');

class Global {
  static late SharedPreferences _prefs;
  static String avator = 'assets/images/avator/default.png';

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
  }
  // 设置头像
  static setAvator(value) {
    avator = value;
    _prefs.setString('avator', value);
  }


  // 清理数据
  static clear() {
    _prefs.clear();
  }
}