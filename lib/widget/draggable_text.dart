import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/create.dart';

class DraggableText extends StatefulWidget {
  const DraggableText({super.key, required this.options});
  final TextData options;

  @override
  DraggableTextState createState() => DraggableTextState();
}

class DraggableTextState extends State<DraggableText> {
  TextData _textData = TextData(
    key: 'text_test',
    position: Offset(0, 0),
    size: Size(100, 50),
    angle: 0.0,
    text: '',
    onClose: () {}
  );
  bool get _isFocus => CreateController.focusNodeKey.value == _textData.key;

  @override
  void initState() {
    super.initState();
    _textData = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _textData.position.dx,
      top: _textData.position.dy,
      child: GestureDetector(
        onTap: () {
          CreateController.onFocus(_textData.key);
        },
        onPanUpdate: _handleMove,
        child: Transform.rotate(
          angle: _textData.angle,
          child: Obx(() => Container(
            height: _textData.size.height,
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: _isFocus ? Colors.white : Colors.transparent, width: 0.5),
            ),
            child: _isFocus ? Stack(
              clipBehavior: Clip.none,
              children: [
                // 关闭（左上角）
                _buildCloseHandle(),
                // 旋转控制点（顶部中心）
                // _buildRotationHandle(),
                // 大小调整控制点（右下角）
                // _buildResizeHandle(),
                Container(
                  height: _textData.size.height,
                  alignment: Alignment.centerLeft,
                  child: Text(_textData.text, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),),
                ),
              ],
            ) : Text(_textData.text, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),),
          )),
        ),
      ),
    );
  }

  // 移动
  void _handleMove(DragUpdateDetails details) {
    setState(() {
      _textData = _textData.copyWith(
        position: _textData.position + details.delta
      );
    });
  }

  // 关闭
  Widget _buildCloseHandle() {
    return Positioned(
      top: -10,
      left: -26,
      child: GestureDetector(
        onTap: _handleClose,
        child: Image.asset('assets/icons/resize_close.png', width: 24)
      )
    );
  }
  _handleClose() {
    _textData.onClose();
    CreateController.decWidget();
  }

  // 大小调整
  Widget _buildResizeHandle() {
    return Positioned(
      right: -18,
      bottom: -8,
      child: GestureDetector(
        onTap: () {CreateController.onFocus(_textData.key);},
        onPanUpdate: _handleResize,
        child: Image.asset('assets/icons/resize_dot.png', width: 16)
      ),
    );
  }
  void _handleResize(DragUpdateDetails details) {
    setState(() {
      _textData = _textData.copyWith(
        size: Size(
          _textData.size.width + details.delta.dx,
          _textData.size.height + details.delta.dy,
        ).constrain(Size(100, 50)), // 最小尺寸限制
      );
    });
  }
}

class TextData {
  final String key;
  final Offset position;
  final Size size;
  final double angle;
  final String text;
  final Function onClose;

  TextData({
    required this.key,
    required this.position,
    required this.size,
    required this.angle,
    required this.text,
    required this.onClose,
  });

  Offset get center => Offset(
    position.dx + size.width / 2,
    position.dy + size.height / 2,
  );

  TextData copyWith({
    Offset? position,
    Size? size,
    double? angle,
  }) {
    CreateController.onFocus(key);
    return TextData(
      key: key,
      position: position ?? this.position,
      size: size ?? this.size,
      angle: angle ?? this.angle,
      text: text,
      onClose: onClose,
    );
  }
}

extension SizeConstraints on Size {
  Size constrain(Size minSize) {
    return Size(
      width < minSize.width ? minSize.width : width,
      height < minSize.height ? minSize.height : height,
    );
  }
}