import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/widget/information.dart';
import 'package:flutter_coin_zone/widget/prediction.dart';
import 'package:flutter_coin_zone/widget/results.dart';

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
          color: Color(0xff0F0F12),
          image: DecorationImage(image: AssetImage('assets/images/home/home_bg.png'), fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Infomation(context),
                  Container(
                    width: 80,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 243, 244, 1),
                      borderRadius: BorderRadius.circular(24)
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(89, 0, 206, 1),
                      borderRadius: BorderRadius.circular(24)
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                // clipBehavior: Clip.none,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Results(),
                          Prediction(),
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
