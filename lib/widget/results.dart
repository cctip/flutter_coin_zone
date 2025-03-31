import 'package:flutter/material.dart';

Widget resultsBox(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Results', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
      SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: __resultItem(context, 'BTC', 'BTC', '88,219.00', true, '1.00', 'Claim', (){})
          ),
          SizedBox(width: 10),
          Expanded(
            child: __resultItem(context, 'ETH', 'ETH', '2,219.00', false, '2.12', 'Faild', null)
          ),
          SizedBox(width: 10),
          Expanded(
            child: __resultItem(context, 'SOL', 'SOL', '119.43', true, '0.12', 'Claimed', null)
          ),
        ],
      ),
      SizedBox(height: 32)
    ],
  );
}

Widget __resultItem(context, icon, title, money, rise, rate, btn, func) {
  return Container(
    height: 134,
    padding: EdgeInsets.all(16),
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('assets/images/home/$icon.png', width: 32),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: Color(0xFF1B191C), fontWeight: FontWeight.w500))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$$money', style: TextStyle(fontSize: 12)),
            // ignore: prefer_interpolation_to_compose_strings
            Text((rise?'+':'-')+'$rate%', style: TextStyle(color: Color(rise ? 0xFF3AD164 : 0xFFFF5151), fontSize: 12)),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF0C0C0D),
              disabledForegroundColor: Color(0xFF2D2A2F),
              disabledBackgroundColor: Color.fromRGBO(12, 12, 13, 0.15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: func,
            child: Text(btn, style: TextStyle(fontSize: 12))
          )
        )
      ],
    ),
  );
}