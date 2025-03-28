import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/widget/information.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          image: DecorationImage(image: AssetImage('assets/images/profile/profile_bg.png'), fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Infomation(context),
                  InkWell(
                    child: Image.asset('assets/icons/settings.png', width: 24),
                    onTap: () {
                      Navigator.pushNamed(context, 'setting');
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Color.fromRGBO(255, 255, 255, 0.3)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Points', style: TextStyle(color: Color.fromRGBO(27, 25, 28, 0.5), fontSize: 12)),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/icons/star.png', width: 16),
                                                SizedBox(width: 4),
                                                Text('999', style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16, fontWeight: FontWeight.w500))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Color.fromRGBO(255, 255, 255, 0.3)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Predictions', style: TextStyle(color: Color.fromRGBO(27, 25, 28, 0.5), fontSize: 12)),
                                            Text('8', style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16, fontWeight: FontWeight.w500))
                                          ],
                                        ),
                                      )
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Color.fromRGBO(255, 255, 255, 0.3)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Successful', style: TextStyle(color: Color.fromRGBO(27, 25, 28, 0.5), fontSize: 12)),
                                            Text('4', style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16, fontWeight: FontWeight.w500))
                                          ],
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Container(
                                  height: 142,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Checked in for', style: TextStyle(color: Color(0xFF2D2A2F), fontSize: 12)),
                                          SizedBox(width: 4),
                                          Text('2 Days', style: TextStyle(color: Color(0xFF5900CE), fontSize: 16, fontWeight: FontWeight.w500)),
                                          SizedBox(width: 4),
                                          Text('in a row', style: TextStyle(color: Color(0xFF2D2A2F), fontSize: 12)),
                                          Spacer(),
                                          SizedBox(
                                            width: 90,
                                            height: 28,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                                foregroundColor: Colors.white,
                                                backgroundColor: Color(0xFF0C0C0D),
                                                disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                                                disabledBackgroundColor: Color(0xFFEDEFF1),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              ),
                                              onPressed: () {},
                                              child: Text('Check in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                                            ),
                                          )
                                        ],
                                      ),
                                      LayoutBuilder(
                                        builder: (BuildContext context, BoxConstraints constraints) {
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                DailyItem(1),
                                                DailySpace(),
                                                DailyItem(2),
                                                DailySpace(),
                                                DailyItem(3),
                                                DailySpace(),
                                                DailyItem(4),
                                                DailySpace(),
                                                DailyItem(5),
                                                DailySpace(),
                                                DailyItem(6),
                                                DailySpace(),
                                                DailyItem(7),
                                              ],
                                            ),
                                          );
                                        }
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 126,
                                      height: 36,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Color(0xFF5900CE), width: 2))
                                      ),
                                      child: Text('Level challenge', style: TextStyle(color: Color(0xFF1B191C), fontSize: 16, fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      width: 126,
                                      height: 36,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        // border: Border(bottom: BorderSide(color: Color(0xFF5900CE), width: 2))
                                      ),
                                      child: Text('My Create', style: TextStyle(color: Color(0xFF2D2A2F))),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                ChallengeItem(),
                                ChallengeItem(),
                                ChallengeItem(),
                                ChallengeItem(),
                                ChallengeItem(),
                                ChallengeItem(),
                                ChallengeItem(),
                                ChallengeItem(),
                                SizedBox(height: MediaQuery.of(context).padding.bottom + 56)
                              ],
                            ),
                          ),
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

  Widget DailyItem(day) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 48,
            padding: EdgeInsets.only(top: 4, bottom: 2),
            decoration: BoxDecoration(
              color: Color(0xFFF2F3F4),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/star_blur.png', width: 16),
                Text('+10', style: TextStyle(color: Color.fromRGBO(45, 42, 47, 0.3)))
              ],
            ),
          ),
          SizedBox(height: 4),
          Text('Day $day', style: TextStyle(color: Color.fromRGBO(45, 42, 47, 0.3), fontSize: 12))
        ],
      ),
    );
  }
  Widget DailySpace() {
    return Container(
      width: 12,
      height: 2,
      margin: EdgeInsets.fromLTRB(4, 0, 4, 16),
      decoration: BoxDecoration(
        color: Color(0xFF5900CE),
        borderRadius: BorderRadius.circular(2)
      ),
    );
  }

  Widget ChallengeItem() {
    return Container(
      height: 56,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F4),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Text('Predict 3 times', style: TextStyle(color: Color(0xFF1B191C))),
          Container(
          )
        ],
      ),
    );
  }
}