import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '/controller/user.dart';
import '/controller/prediction.dart';
import '/common/utils.dart';

class PredictionBox extends StatefulWidget {
  const PredictionBox({super.key, required this.loading});
  final bool loading;

  @override
  State<PredictionBox> createState() => PredictionBoxState();
}

class PredictionBoxState extends State<PredictionBox> {
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
  int btcUpProgress = 0;
  int ethUpProgress = 0;
  int solUpProgress = 0;

  @override
  initState() {
    super.initState();
    _calculatePrtValue();
  }

  // 计算预测值
  _calculatePrtValue() {
    final now = DateTime.now();
    final today6 = DateTime(now.year, now.month, now.day, 6);
    final today12 = DateTime(now.year, now.month, now.day, 12);
    final today18 = DateTime(now.year, now.month, now.day, 18);
    final today24 = DateTime(now.year, now.month, now.day, 24);
    if (today6.isBefore(now) && today12.isAfter(now)) {
      // 6-12点 上涨：生成（1%-60%）的随机数，下跌=(100%-上涨的随机数）
      btcUpProgress = Random().nextInt(60) + 1;
      ethUpProgress = Random().nextInt(60) + 1;
      solUpProgress = Random().nextInt(60) + 1;
    } else if (today12.isBefore(now) && today18.isAfter(now)) {
      // 12-18点 上涨：生成（1%-50%）的随机数，下跌=(100%-上涨的随机数）
      btcUpProgress = Random().nextInt(50) + 1;
      ethUpProgress = Random().nextInt(50) + 1;
      solUpProgress = Random().nextInt(50) + 1;
    } else if (today18.isBefore(now) && today24.isAfter(now)) {
      // 18-24点 上涨（1%-40%）的随机数，下跌=(100%-上涨的随机数）
      btcUpProgress = Random().nextInt(40) + 1;
      ethUpProgress = Random().nextInt(40) + 1;
      solUpProgress = Random().nextInt(40) + 1;
    }
  }

  // 点击预测
  _onPredict(index, type) {
    UserController.increasePoint(20);
    UserController.increaseExp(10);
    Utils.showRewardDialog(context, points: 20, exp: 10);
    switch(index) {
      case 0: PredictionController.onPredictBTC('Up'); break;
      case 1: PredictionController.onPredictETH('Up'); break;
      case 2: PredictionController.onPredictSOL('Up'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(predictionList.length, (index) => __predictionItem(predictionList[index], index)),
    );
  }

  Widget __predictionItem(item, index) {
    final data = item['data'] ?? {
      'price': 0.00,
      'rate': 0.00,
      'risePrice': 0.00,
      'predict': ''
    };
    final spotsList = [
      const [FlSpot(0, 10),FlSpot(1, 9),FlSpot(2, 9.5),FlSpot(3, 8.8),FlSpot(4, 8.5),FlSpot(5, 7.2),FlSpot(6, 6.3),FlSpot(7, 6.6),FlSpot(8, 5.3),FlSpot(9, 6.2),FlSpot(10, 3.7),FlSpot(11, 5.3),FlSpot(12, 2.1),FlSpot(13, 3.3),],
      const [FlSpot(0, 9),FlSpot(1, 9),FlSpot(2, 9.5),FlSpot(3, 8.8),FlSpot(4, 9.5),FlSpot(5, 8.0),FlSpot(6, 8.3),FlSpot(7, 7.6),FlSpot(8, 8.3),FlSpot(9, 7.2),FlSpot(10, 4.7),FlSpot(11, 5.3),FlSpot(12, 4.1),FlSpot(13, 1.3),],
      const [FlSpot(0, 8.7),FlSpot(1, 9.8),FlSpot(2, 9.0),FlSpot(3, 9.4),FlSpot(4, 8.5),FlSpot(5, 9.2),FlSpot(6, 6.3),FlSpot(7, 6.6),FlSpot(8, 6.3),FlSpot(9, 6.5),FlSpot(10, 7.2),FlSpot(11, 7.3),FlSpot(12, 5.1),FlSpot(13, 1.3),FlSpot(14, 1.2),]
    ];
    final progressList = [btcUpProgress, ethUpProgress, solUpProgress];
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
                          lineTouchData: const LineTouchData(enabled: false),
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
                              spots: spotsList[index]
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
                  data['predict'] != '' ? __progressBtn('Up', progressList[index], data['predict'] == 'Up') : Expanded(
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
                        _onPredict(index, 'Up');
                      },
                      child: Text('Up', style: TextStyle(fontSize: 16))
                    ),
                  ),
                  SizedBox(width: 8),
                  data['predict'] != '' ? __progressBtn('Down', 100 - progressList[index], data['predict'] == 'Down') : Expanded(
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
                        _onPredict(index, 'Down');
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
}