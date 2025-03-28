import 'package:flutter/material.dart';

Widget Prediction() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Prediction', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
      SizedBox(height: 12),
      Column(
        children: [
          Container(
            height: 244,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32)
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 244,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32)
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 244,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32)
            ),
          ),
        ],
      )
    ],
  );
}