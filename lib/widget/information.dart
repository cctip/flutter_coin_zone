import 'package:flutter/material.dart';

String avator = 'assets/images/avator/3.png';

Widget Infomation(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 48,
        height: 48,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)
        ),
        child: ClipOval(
          child: Image.asset(avator, fit: BoxFit.cover),
        )
      ),
      SizedBox(width: 12),
      Container(
        width: 140,
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lvl 10', style: TextStyle(color: Color(0xFF1B191C), fontSize: 16, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Image.asset('assets/icons/exp.png', width: 16),
                    Text('200', style: TextStyle(color: Color(0xFF1B191C))),
                    Text('/200', style: TextStyle(color: Color.fromRGBO(27, 25, 28, 0.5), fontSize: 12)),
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(12, 12, 13, 0.3),
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 70,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(12, 12, 13, 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
    ],
  );
}