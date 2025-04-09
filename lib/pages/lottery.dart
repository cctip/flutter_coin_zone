import 'package:flutter/material.dart';
import 'dart:math';
import '/controller/user.dart';
import '/controller/sticker.dart';

class LotteryView extends StatefulWidget {
  const LotteryView({super.key});

  @override
  State<LotteryView> createState() => LotteryViewState();
}

class LotteryViewState extends State<LotteryView> with SingleTickerProviderStateMixin {
  final List<Image> prizes = [
    Image.asset('assets/icons/star.png', width: 48),
    Image.asset('assets/icons/exp.png', width: 48),
    Image.asset('assets/icons/reward_nft.png', width: 48),
  ];
  final _scrollControllers = List.generate(3, (_) => ScrollController());
  final List<double> _randomOffsets = [0, 0, 0];
  late AnimationController _animationController;
  final double _itemHeight = 70;
  bool runing = false;
  int _endingCount = 0;
  int _endIndex = 0;
  String spinType = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
  }

  // 开始抽奖
  void _startSpin(type) {
    if (runing) return;
    if (type == 'free' && UserController.freeSpined.value) return;
    if (type == 'fee' && (UserController.points.value < 500)) return;
    spinType = type;
    _animationController.reset();
    setState(() {
      runing = true;
      _endIndex = Random().nextInt(3);
    });

    // 递归随机数生成
    getRandom(index) {
      double randomOffset = (Random().nextInt(20) + 5) * _itemHeight * prizes.length + _endIndex * _itemHeight; // 保证完整滚动圈数
      if (randomOffset > _randomOffsets[index] - 1000 && randomOffset < _randomOffsets[index] + 1000) {
        randomOffset = getRandom(index);
      }
      _randomOffsets[index] = randomOffset;
      return randomOffset;
    }
    _scrollControllers.asMap().forEach((index, controller) {
      controller.animateTo(
        getRandom(index),
        duration: Duration(seconds: 3),
        curve: Curves.easeOutQuart,
      );
    });
  }

  // 结束抽奖
  void _endSpin() {
    setState(() {
      _endingCount++;
      if (_endingCount == prizes.length) {
        runing = false;
        _endingCount = 0;
      }
    });
    if (runing) return;
    if (spinType == 'free') {
      UserController.onFreeSpin();
    } else {
      UserController.decreasePoint(500);
    }

    int starCount = 0;
    int expCount = 0;
    String nftImage = '';
    if (_endIndex == 0) {
      int n = Random().nextInt(200) + 1; // 1到200随机数
      starCount = 5 * n;
      UserController.increasePoint(starCount);
    } else if (_endIndex == 1) {
      int n = Random().nextInt(50) + 1; // 1到50随机数
      expCount = 10 * n;
      UserController.increaseExp(expCount);
    } else if (_endIndex == 2) {
      if (StickerController.remainList.isEmpty) {
        setState(() => _endIndex = 0);
        int n = Random().nextInt(200) + 1; // 1到200随机数
        starCount = 5 * n;
        UserController.increasePoint(starCount);
      } else {
        int n = Random().nextInt(StickerController.remainList.length);
        nftImage = StickerController.remainList[n];
        StickerController.resiveSticker(n);
      }
    }
    Widget _rewardImage() {
      if (_endIndex == 0) {
        return Image.asset('assets/icons/star.png', width: 120);
      } else if (_endIndex == 1) {
        return Image.asset('assets/icons/exp.png', width: 120);
      } else if (_endIndex == 2) {
        return Image.asset(nftImage, width: 242);
      } else {
        return Container();
      }
    }
    
    showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black87,
      builder: (_) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 点击内容区域关闭
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + kToolbarHeight + 20, 16, MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Image.asset('assets/images/lottery/dialog_title.png'),
              ),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 68,
                    left: 24,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: Opacity(opacity: 0.5, child: Image.asset('assets/images/lottery/dialog_decration.png')),
                    )
                  ),
                  Positioned(child: Image.asset('assets/images/lottery/dialog_mask.png')),
                  Positioned(child: _rewardImage()),
                ],
              ),
              Text('You got a reward${_endIndex == 2 ? '' : 'of'}', style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Outfit',
                decoration: TextDecoration.none
              )),
              _endIndex == 2 ? Container() : Container(
                width: 200,
                height: 64,
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(12, 12, 13, 0.8),
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/${_endIndex == 0 ? 'star' : 'exp'}.png', width: 32),
                    SizedBox(width: 8),
                    Text(_endIndex == 0 ? '$starCount' : '$expCount', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Outfit',
                      decoration: TextDecoration.none
                    ))
                  ],
                ),
              ),
              Spacer(),
              Text('Tap anywhere to claim your reward', style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none
              )),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 80)
            ],
          ),
        )
      )
    );
  }

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/star.png', width: 16),
                          SizedBox(width: 4),
                          Text(UserController.points.value.toString(), style: TextStyle(color: Colors.white, fontSize: 16))
                        ],
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
            Stack(
              children: [
                Image.asset('assets/images/lottery/slots.png'),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.18,
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.681,
                    child: _buildSlotMachine(),
                  )
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 68),
              child: InkWell(
                onTap: () { _startSpin('free'); },
                child: Image.asset('assets/images/lottery/${UserController.freeSpined.value ? 'btn_FreeSpined' : 'btn_FreeSpin'}.png', height: 54),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: InkWell(
                onTap: () { _startSpin('fee'); },
                child: Image.asset('assets/images/lottery/${UserController.points.value < 500 ? 'btn_UseSpined' : 'btn_UseSpin'}.png', height: 54),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _buildSlotMachine() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _scrollItem(0),
          SizedBox(width: 4),
          _scrollItem(1),
          SizedBox(width: 4),
          _scrollItem(2),
        ]
      ),
    );
  }

  Widget _scrollItem(index) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.681 - 8) / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(index == 0 ? 16 : 8),
          topRight: Radius.circular(index == 2 ? 16 : 8),
          bottomLeft: Radius.circular(index == 0 ? 16 : 8),
          bottomRight: Radius.circular(index == 2 ? 16 : 8),
        )
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollEndNotification: _endSpin(); break;
          }
          return true;
        },
        child: ListView.builder(
          padding: EdgeInsets.only(top: 35),
          controller: _scrollControllers[index],
          physics: NeverScrollableScrollPhysics(),
          itemCount: prizes.length * 100, // 确保足够滚动长度
          itemBuilder: (_, i) => Container(
            height: _itemHeight,
            alignment: Alignment.center,
            child: prizes[i % prizes.length],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}