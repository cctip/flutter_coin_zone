import 'package:flutter/material.dart';

Widget Prediction() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Prediction', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
      Column(
        children: [
          PredictionItem(),
          PredictionItem(),
          PredictionItem(),
        ],
      )
    ],
  );
}

Widget PredictionItem() {
  return Container(
    height: 244,
    margin: EdgeInsets.only(top: 16),
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/images/home/BTC.png', width: 48),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BTC'),
                Text('Bitcoin'),
              ],
            ),
            Spacer(),
            Image.asset('assets/images/home/chart.png', width: 40)
          ],
        ),
        Container(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3AD164),
                  disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                  disabledBackgroundColor: Color(0xFFEDEFF1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                child: Text('Up', style: TextStyle(fontSize: 16))
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFFF5151),
                  disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                  disabledBackgroundColor: Color(0xFFEDEFF1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                child: Text('Down', style: TextStyle(fontSize: 16))
              ),
            )
          ],
        )
      ],
    ),
  );
}