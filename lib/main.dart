import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/lottery.dart';
import 'pages/index.dart';
import 'pages/create.dart';
import 'pages/profile.dart';
import 'pages/setting.dart';
import 'common/share_pref.dart';

void main() => SharePref.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Outfit',
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(89, 0, 206, 1)),
      ),
      routes: {
        "/": (context) => IndexPage(),
        "create": (context) => CreateView(),
        "lottery": (context) => LotteryView(),
        'profile': (context) => ProfileView(),
        'setting': (context) => SettingView(),
      },
      initialRoute: '/',
    );
  }
}