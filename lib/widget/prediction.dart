import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/controller/prediction.dart';
import 'package:get/get.dart';

class PredictionBox extends StatefulWidget {
  const PredictionBox({super.key});

  @override
  State<PredictionBox> createState() => PredictionBoxState();
}

class PredictionBoxState extends State<PredictionBox> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  String timeText = 'Ends in';
  List<Object> predictionList = [
    {
      'data': PredictionController.btcOptions,
      'name': 'BTC',
      'subname': 'Bitcoin',
      'icon': 'assets/images/home/BTC.png',
      'price': 87123.02,
      'rate': 1.00,
      'risePrice': 3901.23,
      'show': false,
    },
    {
      'data': PredictionController.ethOptions,
      'name': 'ETH',
      'subname': 'Ethereum',
      'icon': 'assets/images/home/ETH.png',
      'price': 2932.02,
      'rate': -2.73,
      'risePrice': -542.23,
      'show': false
    },
    {
      'data': PredictionController.solOptions,
      'name': 'SOL',
      'subname': 'Solana',
      'icon': 'assets/images/home/SOL.png',
      'price': 87123.02,
      'rate': 1.00,
      'risePrice': 3901.23,
      'show': false
    },
  ];

  @override
  initState() {
    super.initState();
    _calculateTime();
    _startTimer();
  }
  void _calculateTime() {
    final now = DateTime.now();
    final today18 = DateTime(now.year, now.month, now.day, 18);
    final today24 = DateTime(now.year, now.month, now.day, 24);
    
    setState(() {
      if (today18.isAfter(now)) {
        _remainingTime = today18.difference(now);
        timeText = 'Ends in';
      } else {
        _remainingTime = today24.difference(now);
        timeText = 'Starts in';
      }
    });
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
      }
      _calculateTime();
    });
  }
  String _formatDuration(Duration d) {
    return "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  void _showRoleDialog() {
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

  @override
  Widget build(BuildContext context) {
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
                  child: Text('$timeText ${_formatDuration(_remainingTime)}', style: TextStyle(color: Colors.white, fontSize: 12)),
                )
              ],
            ),
            InkWell(
              child: Image.asset('assets/icons/info.png', width: 24),
              onTap: () {
                _showRoleDialog();
              },
            )
          ],
        ),
        Column(
          children: List.generate(predictionList.length, (index) => __predictionItem(predictionList[index])),
        )
      ],
    );
  }

  Widget __predictionItem(item) {
    final data = item['data'] ?? {
      'price': 0.00,
      'rate': 0.00,
      'risePrice': 0.00,
    };
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
              Image.asset(item['icon'], width: 48),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name']),
                  Text(item['subname']),
                ],
              ),
              Spacer(),
              InkWell(
                child: Image.asset('assets/images/home/chart${item['show'] ? '_active' : ''}.png', width: 40),
                onTap: () {
                  setState(() {
                    item['show'] = !item['show'];
                  });
                },
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${data['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    Text('24h Change', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(45, 42, 47, 0.5))),
                    Text(
                      '${data['rate'] >= 0 ? '+' : ''}${data['rate'].toStringAsFixed(2)}% (${data['rate'] >= 0 ? '+' : ''}\$${data['risePrice'].toStringAsFixed(2)})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: data['rate'] >= 0 ? Color(0xFF3AD164) : Color(0xFFFF5151)
                      )
                    ),
                  ],
                )),
                item['show'] ? SizedBox(
                  width: 150,
                  height: 60,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true, // 启用曲线效果
                          isStrokeCapRound: true, // 两端圆弧
                          color: Colors.black,
                          barWidth: 2,
                          dotData: FlDotData(show: false),
                          spots: const [
                            FlSpot(0, 1),
                            FlSpot(1, 0),
                            FlSpot(2, 2.5),
                            FlSpot(3, 5),
                            FlSpot(4, 10),
                            FlSpot(5, 53),
                            FlSpot(6, 213),
                            FlSpot(7, 55),
                            FlSpot(8, 324),
                            FlSpot(9, 65),
                            FlSpot(10, 12),
                          ]
                        )
                      ]
                    ),
                  )
                ) : Container()
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class PredictionItem extends StatefulWidget {
  const PredictionItem({ super.key, name, subName, icon, price, rise, rate, risePrice, show });

  @override
  State<PredictionItem> createState() => PredictionItemState();
}
class PredictionItemState extends State<PredictionItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}