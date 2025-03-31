import 'package:flutter/material.dart';

Widget predictionBox() {
  return Builder(
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Prediction', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700, height: 1)),
                  Container(
                    height: 22,
                    margin: EdgeInsets.only(left: 8),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(27, 25, 28, 0.35),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text('Ends in 12:02:21', style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
              InkWell(
                child: Image.asset('assets/icons/info.png', width: 24),
                onTap: () {
                  _showRoleDialog(context);
                },
              )
            ],
          ),
          Column(
            children: [
              __predictionItem(),
              __predictionItem(),
              __predictionItem(),
            ],
          )
        ],
      );
    }
  );
}

Widget __predictionItem() {
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
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$87,123.02', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                  Text('24h Change', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(45, 42, 47, 0.5))),
                  Text('+1.00% (+\$3901.23)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF3AD164))),
                ],
              ),
              Container(
                color: Colors.amber,
                child: CustomPaint(
                  size: Size(140, 70),
                  painter: PathPainter(
                    path: drawPath(),
                  ),
                ),
              )
            ],
          )
        ),
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

class PathPainter extends CustomPainter {
  Path path;
  PathPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    // paint the line
    final paint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; 
}

Path drawPath() {
  final path = Path();
  path.moveTo(0, 70);
  path.lineTo(140 / 2, 70 * 0.5);
  path.lineTo(140, 70 * 0.75);
  return path;
}


_showRoleDialog(context) {
  showDialog(
    context: context,
    useSafeArea: false,
    // barrierColor: Colors.transparent,
    builder: (_) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 510,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
          ),
          child: Column(
            children: [
              Image.asset('assets/images/home/rule_title.png'),
              SizedBox(height: 10),
              Image.asset('assets/images/home/rule_text.png'),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 58,
                padding:EdgeInsets.symmetric(horizontal: 24) ,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.white,
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF0C0C0D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Got it', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              Spacer(),
            ],
          )
        )
      ],
    )
  );
}