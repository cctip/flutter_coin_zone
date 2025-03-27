import 'package:flutter/material.dart';
import '../common/Global.dart';


String avator = Global.avator; // 头像

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  List globalKeys = [];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true, // 滑动到顶端时会固定住
            backgroundColor: Colors.black,
            // expandedHeight: 80,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text('Profile', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'setting');
                },
                child: Image.asset('assets/icons/icon_setting.png', width: 24,),
              ),
              SizedBox(width: 16)
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
			),
		);
	}
}