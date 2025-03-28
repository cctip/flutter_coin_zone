import 'package:flutter/material.dart';

class LotteryView extends StatefulWidget {
  const LotteryView({super.key});

  @override
  State<LotteryView> createState() => LotteryViewState();
}

class LotteryViewState extends State<LotteryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F4),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          image: DecorationImage(image: AssetImage('assets/images/lottery/lottery_bg.png'), fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top + 64,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 16,
                    child: InkWell(
                      child: Image.asset('assets/icons/close_light.png', width: 32),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ),
                  Positioned(
                    right: 16,
                    child: Container(
                      width: 80,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 243, 244, 0.4),
                        borderRadius: BorderRadius.circular(24)
                      ),
                    )
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 58),
              child: Image.asset('assets/images/lottery/lottery_title.png')
            ),
            SizedBox(height: 20),
            Container(
              child: Image.asset('assets/images/lottery/slots.png'),
            ),
            SizedBox(height: 68),
            Container(
              child: Image.asset('assets/images/lottery/btn_FreeSpin.png', height: 54),
            ),
            SizedBox(height: 16),
            Container(
              child: Image.asset('assets/images/lottery/btn_UseSpin.png', height: 54),
            )
          ],
        ),
      )
    );
  }
}