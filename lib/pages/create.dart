import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '/common/eventbus.dart';
import '/widget/draggable_widget.dart';
import '/widget/draggable_text.dart';
import '/controller/create.dart';
import '/controller/sticker.dart';

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => CreateViewState();
}

class CreateViewState extends State<CreateView> {
  final ScreenshotController _scController = ScreenshotController();
  bool get savable => CreateController.widgetCount.value > 0;
  XFile bgImage = XFile(''); // 选择的背景图
  int curTab = 0; // 当前操作栏
  List<Color> colorList = [
    Color(0xFFEDEFF1),
    Color(0xFF5900CE),
    Color(0xFF00E09E),
    Color(0xFF4BC9FF),
    Color(0xFFFFA1FB),
    Color(0xFFFF434E),
    Color(0xFFFF7D28),
    Color(0xFF54E500)
  ];
  int curColor = 0;
  double curBlur = 1;

  get stickerList => StickerController.stickerList;
  List<WidgetData> widgetList = [];
  List<TextData> textList = [];
  String textVal = '';

  // 打开相册选择图片
  _openGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      String key = 'widget_${widgetList.length + 1}';
      widgetList.add(WidgetData(
        key: key,
        position: Offset(100, 100),
        size: Size(100, 100),
        angle: 0.0,
        image: Image.file(File(image.path), fit: BoxFit.fill,),
        onClose: () {}
      ));
      CreateController.incWidget();
      CreateController.onFocus(key);
      // bgImage = image;
    });
  }

  // 新增可拖拽图片控件
  _addDraggableWidget(Image image) {
    int widgetLength = widgetList.length;
    setState(() {
      String key = 'widget_${widgetList.length + 1}';
      widgetList.add(WidgetData(
        key: key,
        position: Offset(100, 100),
        size: Size(100, 100),
        angle: 0.0,
        image: image,
        onClose: () {
          setState(() {
            widgetList.removeAt(widgetLength);
          });
        }
      ));
      CreateController.incWidget();
      CreateController.onFocus(key);
    });
  }

  // 新增可拖拽文字控件
  _addDraggableText(text) {
    int textLength = textList.length;
    setState(() {
      String key = 'text_${textList.length + 1}';
      textList.add(TextData(
        key: key,
        position: Offset(100, 100),
        size: Size(100, 50),
        angle: 0.0,
        text: text,
        onClose: () {
          setState(() {
            textList.removeAt(textLength);
          });
        }
      ));
      CreateController.onFocus(key);
    });
  }

  // 保存到我的NFT
  _onSave() async {
    CreateController.cancelFocus();
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // 生成截图
    _scController.capture(pixelRatio: pixelRatio).then((imageByte) async {
      var tempDir = await getApplicationSupportDirectory();
      var file = await File('${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png').create();
      file.writeAsBytesSync(imageByte as Uint8List);
      bus.emit('nftCreate');
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (_) => Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/create/result_bg.png'),
            Positioned(child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top + 64,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 16),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Image.asset('assets/icons/arrow_left.png', width: 32),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  width: 185,
                  height: 247,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image.memory(imageByte),
                ),
                SizedBox(height: 24),
                Text(
                  'Saved Successfully',
                  style: TextStyle(
                    color: Color(0xFF1B191C),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Outfit',
                    decoration: TextDecoration.none
                  )
                ),
                SizedBox(height: 64),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF0C0C0D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // 点击内容区域关闭
                    },
                    child: Text('Continue Creating', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.all(0),
                      foregroundColor: Color(0xFF1B191C),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      side: BorderSide(color: Color(0xFF0C0C0D), width: 1),
                    ),
                    onPressed: () {
                      CreateController.clearWidget();
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text('Back home', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
                  ),
                ),
              ],
            ))
          ],
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F4),
      body: GestureDetector(
        onTapCancel: CreateController.cancelFocus,
        onTap: CreateController.cancelFocus,
        child: Column(
          children: [
            header(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: createPanel(),
              )
            ),
            controlPanel()
          ],
        )
      )
    );
  }

  // 头部
  Widget header() {
    return Container(
      height: MediaQuery.of(context).padding.top + 64,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16,
            child: InkWell(
              child: Image.asset('assets/icons/close.png', width: 32),
              onTap: () {
                CreateController.clearWidget();
                Navigator.pop(context);
              },
            )
          ),
          Center(
            child: Text('NFT Creation', style: TextStyle(color: Color(0xFF1B191C), fontSize: 18, fontWeight: FontWeight.w500))
          ),
          Positioned(
            right: 16,
            child: Container(
              width: 67,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xFFEDEFF1),
                borderRadius: BorderRadius.circular(16)
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF0C0C0D),
                  disabledForegroundColor: Color.fromRGBO(27, 25, 28, 0.3),
                  disabledBackgroundColor: Color(0xFFEDEFF1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: savable ? _onSave : null,
                child: Text('Save', style: TextStyle(fontSize: 16))
              ),
            )
          ),
        ],
      ),
    );
  }

  // 绘制面板
  Widget createPanel() {
    return Builder(builder: ((ctx) => Screenshot(
      controller: _scController,
      child: Opacity(
        opacity: curBlur,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: colorList[curColor],
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(119, 119, 119, 0.15),
                offset: Offset(-2, -2),
                blurRadius: 5,
                spreadRadius: 0
              ),
              BoxShadow(
                color: Color.fromRGBO(119, 119, 119, 0.15),
                offset: Offset(2, 2), // 阴影偏移量 (水平, 垂直)
                blurRadius: 5, // 阴影模糊程度
                spreadRadius: 0, // 阴影扩散范围
              ),
            ]
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                height: MediaQuery.of(ctx).size.height,
                child: bgImage.path != '' ? Image.file(File(bgImage.path)) : Container(),
              ),
              ...List.generate(widgetList.length, (index) => DraggableBoard(options: widgetList[index])),
              ...List.generate(textList.length, (index) => DraggableText(options: textList[index])),
            ],
          )
        ),
      )
    )));
  }

  // 操作面板
  Widget controlPanel() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 64,
                width: MediaQuery.of(context).size.width - 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    tabItem(0, 'Colors'),
                    tabItem(1, 'Stickers'),
                    tabItem(2, 'Text'),
                    tabItem(3, 'Vague'),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            child: IndexedStack(
              index: curTab,
              children: [
                colorsBox(),
                stickersBox(),
                textBox(),
                vagueBox()
              ],
            ),
          )
        ],
      ),
    );
  }

  // 切换操作tab
  Widget tabItem(int index, String name) {
    final opt = {
      'Colors': 'colors',
      'Stickers': 'sticker',
      'Text': 'text',
      'Vague': 'blur',
    };
    return Expanded(child: InkWell(
      onTap: (){
        setState(() {
          curTab = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IndexedStack(
            index: curTab == index ? 1 : 0,
            children: [
              Image.asset('assets/images/create/${opt[name]}.png', width: 24),
              Image.asset('assets/images/create/${opt[name]}_active.png', width: 26),
            ],
          ),
          SizedBox(width: 4),
          Text(name, style: TextStyle(
            color: Color(curTab == index ? 0xFF5900CE : 0xFF1B191C),
            fontSize: curTab == index ? 16 : 14,
            fontWeight: curTab == index ? FontWeight.w500 : FontWeight.w400
          ))
        ],
      )
    ));
  }

  // Colors
  Widget colorsBox() {
    Widget colorItem(int index) {
      return InkWell(
        onTap: () {
          setState(() { curColor = index; });
        },
        child: Container(
          width: 64,
          height: 64,
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            border: Border.all(color: curColor == index ? colorList[index] : Colors.transparent),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Container(decoration: BoxDecoration(color: colorList[index], borderRadius: BorderRadius.circular(12))),
        ),
      );
    }
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: _openGallery,
                child: Container(
                  width: 64,
                  height: 64,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Image.asset('assets/images/create/photo.png', width: 56)
                ),
              ),
              ...List.generate(colorList.length, (index) => colorItem(index)),
            ],
          ),
        );
      }
    );
  }
  // Stickers
  Widget stickersBox() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F3F4),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Image.asset('assets/images/create/add.png', width: 32)
              ),
              ...List.generate(stickerList.length, (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _addDraggableWidget(Image.asset(stickerList[index], fit: BoxFit.fill));
                  });
                },
                child: Container(
                  width: 68,
                  height: 68,
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F3F4),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Image.asset(stickerList[index])
                ),
              )),
            ],
          ),
        );
      }
    );
  }
  // Text
  Widget textBox() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(height: 1),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                hintText: 'Enter text',
                hintStyle: TextStyle(color: Color.fromRGBO(45, 42, 47, 0.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder( // 聚焦状态边框
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: Color(0xFFF2F3F4),
              ),
              onChanged: (val) {
                setState(() {
                  textVal = val;
                });
              }
            )
          ),
          SizedBox(width: 16),
          InkWell(
            child: Image.asset('assets/images/create/check.png', width: 24),
            onTap: () {
              _addDraggableText(textVal);
            },
          )
        ],
      ),
    );
  }
  // Vague
  Widget vagueBox() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Blur', style: TextStyle(color: Color(0xff2D2A2F))),
              Text('${(curBlur * 100).toStringAsFixed(0)}%', style: TextStyle(fontSize: 16))
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            trackHeight: 12,
            thumbShape: _CustomThumbShape(),
          ),
          child: Slider(
            value: curBlur,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            label: (curBlur * 100).toStringAsFixed(0),
            onChanged: (value) {
              setState(() {
                curBlur = value;
              });
            },
            activeColor: Color(0xFF0C0C0D),
            inactiveColor: Color.fromRGBO(12, 12, 13, 0.3),
          ),
        ),
      ],
    );
  }
}

// 核心自定义滑块形状
class _CustomThumbShape extends SliderComponentShape {
  final double thumbRadius = 8; // 滑块半径
  final double dotRadius = 4;    // 白点半径

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // 1. 绘制蓝色外圆
    final Paint outerPaint = Paint()
      ..color = sliderTheme.activeTrackColor! // 使用主题颜色
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, outerPaint);

    // 2. 绘制白色中心点
    final Paint dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, dotRadius, dotPaint);
  }
}