import 'package:flutter/material.dart';

Widget Results() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Results', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
      SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: Container(
              height: 134,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(119, 119, 119, 0.15),
                    offset: Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 0
                  )
                ]
              ),
            )
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 134,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(119, 119, 119, 0.15),
                    offset: Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 0
                  )
                ]
              ),
            )
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 134,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(119, 119, 119, 0.15),
                    offset: Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 0
                  )
                ]
              ),
            )
          ),
        ],
      ),
      SizedBox(height: 32)
    ],
  );
}