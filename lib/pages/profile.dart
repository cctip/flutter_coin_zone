import 'package:flutter/material.dart';
import 'package:flutter_coin_zone/common/global.dart';
import 'package:flutter_coin_zone/widget/information.dart';

int get starCount => Global.starCount;

class ProfileView extends StatefulWidget{
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  int curTab = 0;

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
                  informationBox(context),
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
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            children: [
                              __accountBox(),
                              SizedBox(height: 16),
                              __dailyBox(),
                            ]
                          )
                        ),
                        SizedBox(height: 32),
                        __tabBox()
                      ],
                    )
                  )
                ],
              )
            )
          ],
        )
      )
		);
	}

  // 账号信息
  Widget __accountBox() {
    return Row(
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
                    Text('$starCount', style: TextStyle(color: Color(0xFF0C0C0D), fontSize: 16, fontWeight: FontWeight.w500))
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
    );
  }
  // 每日签到
  Widget __dailyBox() {
    return Container(
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
                  onPressed: () {
                    Global.checkToday();
                  },
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
                    __dailyItem(1),
                    __dailySpace(),
                    __dailyItem(2),
                    __dailySpace(),
                    __dailyItem(3),
                    __dailySpace(),
                    __dailyItem(4),
                    __dailySpace(),
                    __dailyItem(5),
                    __dailySpace(),
                    __dailyItem(6),
                    __dailySpace(),
                    __dailyItem(7),
                  ],
                ),
              );
            }
          )
        ],
      ),
    );
  }
  // 每日签到单个区块
  Widget __dailyItem(day) {
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
  // 每日签到单个间隔线
  Widget __dailySpace() {
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
  
  // 底部Tab
  Widget __tabBox() {
    return Container(
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
              InkWell(
                onTap: () {
                  setState(() {
                    if (curTab == 0) return;
                    curTab = 0;
                  });
                },
                child: Container(
                  width: 126,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: curTab == 0 ? Color(0xFF5900CE) : Colors.transparent, width: 2))
                  ),
                  child: Text('Level challenge', style: TextStyle(
                    color: Color(0xFF1B191C),
                    fontSize: curTab == 0 ? 16 : 14,
                    fontWeight: curTab == 0 ? FontWeight.w500 : FontWeight.w400
                  )),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    if (curTab == 1) return;
                    curTab = 1;
                  });
                },
                child: Container(
                  width: 126,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: curTab == 1 ? Color(0xFF5900CE) : Colors.transparent, width: 2))
                  ),
                  child: Text('My Create', style: TextStyle(
                    color: Color(0xFF1B191C),
                    fontSize: curTab == 1 ? 16 : 14,
                    fontWeight: curTab == 1 ? FontWeight.w500 : FontWeight.w400
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          curTab == 0 ? __challengeBox() : __myNFT(),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 56)
        ],
      )
    );
  }
  // 成就
  Widget __challengeBox() {
    return Column(
      children: [
        __challengeItem('Predict 3 times', 20, false, (){}),
        __challengeItem('Predicted for 2 consecutive days', 50, false, (){}),
        __challengeItem('Checked in for 3 consecutive days', 80, false, (){}),
        __challengeItem('Checked in for 7 consecutive days', 100, true, (){}),
        __challengeItem('Predicted for 7 consecutive days', 200, true, (){}),
        __challengeItem('Successfully predicted 10 times', 300, true, (){}),
        __challengeItem('Successfully predicted 30 times', 900, true, (){}),
        __challengeItem('Successfully predicted 50 times', 2000, true, (){})
      ],
    );
  }
  // 成就单个区块
  Widget __challengeItem(text, exp, disabled, func) {
    return Container(
      height: 56,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F4),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: Color(0xFF1B191C))),
          SizedBox(
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF0C0C0D),
                disabledForegroundColor: Color.fromRGBO(45, 42, 47, 1),
                disabledBackgroundColor: Color.fromRGBO(45, 42, 47, 0.15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: disabled ? null : func,
              child: Row(
                children: [
                  Text('+$exp', style: TextStyle(fontWeight: FontWeight.w400)),
                  SizedBox(width: 2),
                  Image.asset('assets/icons/exp.png', width: 14)
                ],
              )
            ),
          )
        ],
      ),
    );
  }
  // 我的NFT
  Widget __myNFT() {
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - 386 - MediaQuery.of(context).padding.bottom - 56,
    );
  }
}