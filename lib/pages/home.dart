import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/common/utils.dart';
import '/widget/information.dart';
import '/widget/prediction.dart';
import '/widget/results.dart';
import '/controller/user.dart';
import '/controller/prediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _loading = false;
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  String timeText = 'Ends in';
  bool get todayPredict => PredictionController.lastPredictTime.value == DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    UserController.init();
    PredictionController.init();
    getRequest();
    _calculateTime();
    _startTimer();
  }

  // 计算倒计时
  void _calculateTime() {
    final now = DateTime.now();
    final today18 = DateTime(now.year, now.month, now.day, 18);
    final today24 = DateTime(now.year, now.month, now.day, 24);
    
    setState(() {
      if (today18.isAfter(now)) {
        PredictionController.resetPrediction();
        _remainingTime = today18.difference(now);
        timeText = 'Ends in';
      } else {
        PredictionController.initPrtResult();
        _remainingTime = today24.difference(now);
        if (todayPredict) {
          timeText = 'Results in';
        } else {
          timeText = 'Starts in';
        }
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
            height: 500,
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

  // 获取数据
  getRequest() async {
    if (_loading) return;
    setState(() => _loading = true);
    BaseOptions options = BaseOptions(
      // connectTimeout: Duration(seconds: 1),
      // sendTimeout: Duration(seconds: 1),
    );
    options.headers['X-CMC_PRO_API_KEY'] = '4cc00188-ea57-4fb0-aa41-f5f7f4d376bc';
    Dio dio = Dio(options);
    // dio.interceptors.add(LogInterceptor()); // 添加日志拦截器
    try {
      Response response = await dio.get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest');
      setState(() => _loading = false);
      if (response.statusCode == 200) {
        var resData = response.data['data'];
        for(var i = 0; i < resData.length - 1; i++) {
          var item = resData[i];
          if (item['symbol'] == 'BTC') PredictionController.initBtc(item['quote']['USD']);
          if (item['symbol'] == 'ETH') PredictionController.initEth(item['quote']['USD']);
          if (item['symbol'] == 'SOL') PredictionController.initSol(item['quote']['USD']);
        }
      }
    } catch (e) {
      setState(() => _loading = false);
      Utils.toast(context, message: '请求异常: $e');
      print('请求异常: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          image: DecorationImage(image: AssetImage('assets/images/home/home_bg.png'), fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  informationBox(context),
                  Container(
                    width: 80,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 243, 244, 1),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/star.png', width: 16),
                        SizedBox(width: 4),
                        Text(UserController.points.value.toString(), style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16))
                      ],
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 56,
                      height: 36,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(89, 0, 206, 1),
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Image.asset('assets/icons/lottery.png', width: 24),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'lottery');
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          todayPredict ? ResultsBox(loading: _loading) : Container(),
                          SizedBox(height: 12),
                          __predictionTitle(),
                          PredictionBox(loading: _loading),
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 80)
                        ],
                      )
                    )
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }

  Widget __predictionTitle() {
    return Row(
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
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
