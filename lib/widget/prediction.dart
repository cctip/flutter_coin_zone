import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '/controller/prediction.dart';
import '/common/utils.dart';

class PredictionBox extends StatefulWidget {
  const PredictionBox({super.key, required this.loading});
  final bool loading;

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
      'show': false,
    },
    {
      'data': PredictionController.ethOptions,
      'name': 'ETH',
      'subname': 'Ethereum',
      'icon': 'assets/images/home/ETH.png',
      'show': false
    },
    {
      'data': PredictionController.solOptions,
      'name': 'SOL',
      'subname': 'Solana',
      'icon': 'assets/images/home/SOL.png',
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
      _calculateTime();
    });
  }
  String _formatDuration(Duration d) {
    return "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  // Rule弹窗
  void _showRuleDialog() {
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
                _showRuleDialog();
              },
            )
          ],
        ),
        Column(
          children: List.generate(predictionList.length, (index) => __predictionItem(predictionList[index], index)),
        )
      ],
    );
  }

  Widget __predictionItem(item, index) {
    final data = item['data'] ?? {
      'price': 0.00,
      'rate': 0.00,
      'risePrice': 0.00,
      'predict': ''
    };
    return Stack(
      children: [
        Container(
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
              Obx(() => Row(
                children: [
                  data['predict'] != '' ? __progressBtn('Up', 42, data['predict'] == 'Up') : Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF3AD164),
                        disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                        disabledBackgroundColor: Color(0xFFEDEFF1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: timeText == 'Starts in' ? null : () {
                        switch(index) {
                          case 0: PredictionController.onPredictBTC('Up'); break;
                          case 1: PredictionController.onPredictETH('Up'); break;
                          case 2: PredictionController.onPredictSOL('Up'); break;
                        }
                        Utils.showRewardDialog(context, points: 20, exp: 10);
                      },
                      child: Text('Up', style: TextStyle(fontSize: 16))
                    ),
                  ),
                  SizedBox(width: 8),
                  data['predict'] != '' ? __progressBtn('Down', 100 - 42, data['predict'] == 'Down') : Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFFF5151),
                        disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                        disabledBackgroundColor: Color(0xFFEDEFF1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: timeText == 'Starts in' ? null : () {
                        switch(index) {
                          case 0: PredictionController.onPredictBTC('Down'); break;
                          case 1: PredictionController.onPredictETH('Down'); break;
                          case 2: PredictionController.onPredictSOL('Down'); break;
                        }
                        Utils.showRewardDialog(context, points: 20, exp: 10);
                      },
                      child: Text('Down', style: TextStyle(fontSize: 16))
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
        widget.loading ? Positioned(
          top: 16,
          child: Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 244,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(32)),
            child: SizedBox(
              width: 50,
              height: 50,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Color(0xFF5900CE),
                size: 50,
              ),
            ),
          )
        ) : Container(),
      ],
    );
  }

  Widget __progressBtn(name, progress, active) {
    final btnWidth = (MediaQuery.of(context).size.width - 80 - 8) / 2;
    final baseColor = name == 'Up' ? Color.fromRGBO(58, 209, 100, 1) : Color.fromRGBO(255, 81, 81, 1);
    final secColor = name == 'Up' ? Color.fromRGBO(58, 209, 100, 0.25) : Color.fromRGBO(255, 81, 81, 0.25);

    return Container(
      width: btnWidth,
      height: 44,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: secColor,
        border: Border.all(color: active ? baseColor : Colors.transparent),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          active ? Positioned(right: 8, child: Image.asset('assets/icons/${name == 'Up' ? 'predict_up' : 'predict_down'}.png', width: 16)) : Container(),
          Container(
            width: btnWidth * progress / 100,
            height: 44,
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: progress < (name == 'Up' ? 42 : 52) ? (name == 'Up' ? -60 : -80) : 0,
                  child: Text('$name $progress%', style: TextStyle(
                    color: progress < (name == 'Up' ? 42 : 52) ? baseColor : Colors.white)
                  )
                )
              ],
            ),
          ),
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