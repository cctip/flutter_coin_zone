import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/widget/information.dart';
import 'package:flutter_coin_zone/widget/prediction.dart';
import 'package:flutter_coin_zone/widget/results.dart';
import 'package:flutter_coin_zone/controller/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                          resultsBox(context),
                          predictionBox(),
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
