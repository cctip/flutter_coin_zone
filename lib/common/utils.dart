import 'package:flutter/material.dart';

class Utils {
  static toast(context, message) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 点击内容区域关闭
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(message, style: TextStyle(color: Colors.white))
          ],
        ),
      )
    );
  }
}