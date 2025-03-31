import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/common/Global.dart';

class GlobalChangeNotifier extends ChangeNotifier {
  int get starCount => Global.starCount;

  @override
  void notifyListeners() {
    super.notifyListeners(); //通知依赖的Widget更新
  }
}