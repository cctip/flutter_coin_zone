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
                                        )
                                      )
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Color.fromRGBO(255, 255, 255, 0.3)
                                        )
                                      )
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Color.fromRGBO(255, 255, 255, 0.3)
                                        )
                                      )
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Container(
                                  height: 142,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24)
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