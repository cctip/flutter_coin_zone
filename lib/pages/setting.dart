import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/common/share_pref.dart';
import '/controller/challenge.dart';
import '/controller/prediction.dart';
import '/controller/check.dart';
import '/controller/user.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.white,
			body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: false,
            title: Text('Settings', style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ))
          ),
          Column(
            children: [
              linkItem(
                'Share to friends',
                Image.asset('assets/icons/arrow.png', width: 24),
                (){}
              ),
              linkItem(
                'Contact us',
                Image.asset('assets/icons/arrow.png', width: 24),
                (){}
              ),
              linkItem(
                'Privacy policy',
                Image.asset('assets/icons/arrow.png', width: 24),
                (){
                  launchUrl(Uri.parse(''));
                }
              ),
              linkItem(
                'Terms of service',
                Image.asset('assets/icons/arrow.png', width: 24),
                (){
                  launchUrl(Uri.parse(''));
                }
              ),
              linkItem(
                'About',
                Text('v1.0.0', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
                (){
                  launchUrl(Uri.parse(''));
                }
              ),
              linkItem('Clear Cache', Container(), () {
                SharePref.clear();
                UserController.init();
                CheckController.init();
                PredictionController.init();
                ChallengeController.init();
              }),
            ],
          ),
        ],
      ),
		);
	}
}

Widget linkItem(text, Widget rightWidget, func) {
  return SizedBox(
    height: 58,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        overlayColor: Color(0xFF1B191C),
        shadowColor: Colors.transparent,
        elevation: 0, // 阴影
        backgroundColor: Colors.transparent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        )
      ),
      onPressed: func,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(
            color: Color(0xFF1B191C),
            fontSize: 16,
            fontWeight: FontWeight.w400
          )),
          rightWidget
        ],
      ),
    ),
  );
}