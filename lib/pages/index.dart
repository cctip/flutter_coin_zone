import 'package:flutter/material.dart';
import './home.dart';


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
  Widget getItemIcon(String icon) {
    return Image.asset('assets/images/tabbar/$icon.png', width: 24, height: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(40, 0, 40, MediaQuery.of(context).padding.bottom),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.black,
          ),
          child: Row(
            children: [
              Row(
                children: [
                  // getItemIcon('create')
                ],
              )
            ],
          )
        ),
      )
    );
  }
}
