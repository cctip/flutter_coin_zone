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
      // connectTimeout: Duration(seconds: 5),
      // sendTimeout: Duration(seconds: 5),
    );
    options.headers['X-CMC_PRO_API_KEY'] = '4cc00188-ea57-4fb0-aa41-f5f7f4d376bc';
    Dio dio = Dio(options);
    // dio.interceptors.add(LogInterceptor()); // 添加日志拦截器
    try {
      print(1111);
      Response response = await dio.get('https://pro-api.coinmarketcap.com/v1/blockchain/statistics/latest?limit=6');
      setState(() => _loading = false);
      print('response-----');
      print(response);
      if (response.statusCode == 200) {
        Utils.toast(context, message: 'success');
      }
    } catch (e) {
      setState(() => _loading = false);
      Utils.toast(context, message: '请求异常: $e');
      print('请求异常: $e');

      // 数据异常mock数据
      PredictionController.initBtc({
        "quote": {
          "USD": {
            "price": 83992.70629169543,
            "volume_24h": 28916722837.764206,
            "volume_change_24h": 7.014,
            "percent_change_1h": -0.40929091,
            "percent_change_24h": 1.18201722,
            "percent_change_7d": -4.03102322,
            "percent_change_30d": -9.62605797,
            "percent_change_60d": -17.9807943,
            "percent_change_90d": -11.8420612,
            "market_cap": 1666862553988.2407,
            "market_cap_dominance": 61.8136,
            "fully_diluted_market_cap": 1763846832125.6,
            "tvl": null,
            "last_updated": "2025-04-02T06:17:00.000Z"
          }
        }
      });
      PredictionController.initEth({
        "quote": {
          "USD": {
            "price": 1870.494812331682,
            "volume_24h": 14750568323.794884,
            "volume_change_24h": -3.2437,
            "percent_change_1h": 0.41346605,
            "percent_change_24h": -0.71261704,
            "percent_change_7d": -9.63994194,
            "percent_change_30d": -20.85226139,
            "percent_change_60d": -42.52637153,
            "percent_change_90d": -45.21564353,
            "market_cap": 225697545079.13095,
            "market_cap_dominance": 8.316,
            "fully_diluted_market_cap": 225697545079.13,
            "tvl": null,
            "last_updated": "2025-04-02T08:33:00.000Z"
          }
        }
      },);
      PredictionController.initSol({
        "quote": {
          "USD": {
            "price": 125.55766959452826,
            "volume_24h": 2996397742.4388075,
            "volume_change_24h": -2.3007,
            "percent_change_1h": 1.07310826,
            "percent_change_24h": -3.04325686,
            "percent_change_7d": -13.10574383,
            "percent_change_30d": -21.78586342,
            "percent_change_60d": -45.2438627,
            "percent_change_90d": -38.99923981,
            "market_cap": 64348856489.54331,
            "market_cap_dominance": 2.3697,
            "fully_diluted_market_cap": 75025277974.48,
            "tvl": null,
            "last_updated": "2025-04-02T08:33:00.000Z"
          }
        }
      });
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
