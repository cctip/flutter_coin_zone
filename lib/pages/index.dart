import 'package:flutter/material.dart';
import './home.dart';
import './profile.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int currentIndex = 1;

  /// Tab 改变
  void onTabChanged(int index) {
    setState(() {
      if (currentIndex != index) {
        currentIndex = index;
      }
    });
  }
  /// 获取项目 icon
  Widget getItemIcon(String icon, bool active) {
    String suffix = '';
    if (active) suffix = '_active';
    return Image.asset('assets/images/tabbar/$icon$suffix.png', width: 24, height: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: currentIndex,
            children: [
              Container(),
              HomePage(),
              ProfileView(),
            ],
          ),
          SafeArea(child: __bottomBar())
        ],
      ),
    );
  }

  Widget __bottomBar() {
    return Container(
      width: 324,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getItemIcon('create', currentIndex == 0),
                  SizedBox(width: currentIndex == 0 ? 4 : 0),
                  currentIndex == 0 ? Text('Create', style: TextStyle(color: Colors.white)) : Container()
                ],
              ),
            ),
            onTapUp: (_) {
              Navigator.pushNamed(context, 'create');
            },
          ),
          InkWell(
            child: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getItemIcon('home', currentIndex == 1),
                  SizedBox(width: currentIndex == 1 ? 4 : 0),
                  currentIndex == 1 ? Text('Home', style: TextStyle(color: Colors.white)) : Container()
                ],
              ),
            ),
            onTapUp: (_) {
              onTabChanged(1);
            },
          ),
          InkWell(
            child: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getItemIcon('profile', currentIndex == 2),
                  SizedBox(width: currentIndex == 2 ? 4 : 0),
                  currentIndex == 2 ? Text('Profile', style: TextStyle(color: Colors.white)) : Container()
                ],
              ),
            ),
            onTapUp: (_) {
              onTabChanged(2);
            },
          ),
        ],
      )
    );
  }
}
