import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/setting.dart';
import 'common/Global.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lexend',
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(89, 0, 206, 1)),
      ),
      routes: {
        "/": (context) => MyHomePage(),
        'profile': (context) => ProfileView(),
        'setting': (context) => SettingView(),
      },
      initialRoute: '/',
    );
  }
}