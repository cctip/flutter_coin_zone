import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    UserController.init();
    PredictionController.init();
    getRequest();
  }

  getRequest() async {
    setState(() => _loading = true);
    BaseOptions options = BaseOptions(
      connectTimeout: Duration(seconds: 1),
      sendTimeout: Duration(seconds: 1),
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
                          ResultsBox(loading: _loading),
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
}
