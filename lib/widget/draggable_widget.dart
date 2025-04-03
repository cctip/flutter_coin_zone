import 'package:flutter/material.dart';

class DraggableBoard extends StatefulWidget {
  const DraggableBoard({super.key, required this.options});
  final WidgetData options;

  @override
  DraggableBoardState createState() => DraggableBoardState();
}

class DraggableBoardState extends State<DraggableBoard> {
  WidgetData _widgetData = WidgetData(
    position: Offset(0, 0),
    size: Size(100, 100),
    angle: 0.0,
    image: Image.asset('assets/images/stickers/sticker_1.png'),
    onClose: () {}
  );

  @override
  void initState() {
    super.initState();
    _widgetData = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _widgetData.position.dx,
      top: _widgetData.position.dy,
      child: GestureDetector(
        onPanUpdate: _handleMove,
        child: Transform.rotate(
          angle: _widgetData.angle,
          child: Container(
            width: _widgetData.size.width,
            height: _widgetData.size.height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _widgetData.image,
                // 关闭（左上角）
                _buildCloseHandle(),
                // 旋转控制点（顶部中心）
                // _buildRotationHandle(),
                // 大小调整控制点（右下角）
                _buildResizeHandle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMove(DragUpdateDetails details) {
    setState(() {
      _widgetData = _widgetData.copyWith(
        position: _widgetData.position + details.delta
      );
    });
  }

  // 关闭
  Widget _buildCloseHandle() {
    return Positioned(
      top: -12,
      left: -12,
      child: GestureDetector(
        onTap: _handleClose,
        child: Image.asset('assets/icons/resize_close.png', width: 24)
      )
    );
  }
  _handleClose() {
    _widgetData.onClose();
  }

  // 大小调整
  Widget _buildResizeHandle() {
    return Positioned(
      right: -8,
      bottom: -8,
      child: GestureDetector(
        onPanUpdate: _handleResize,
        child: Image.asset('assets/icons/resize_dot.png', width: 16)
      ),
    );
  }
  void _handleResize(DragUpdateDetails details) {
    setState(() {
      _widgetData = _widgetData.copyWith(
        size: Size(
          _widgetData.size.width + details.delta.dx,
          _widgetData.size.height + details.delta.dy,
        ).constrain(Size(50, 50)), // 最小尺寸限制
      );
    });
  }

  // 旋转
  Widget _buildRotationHandle() {
    return Container(
      padding: EdgeInsets.only(bottom: 0),
      child: GestureDetector(
        onPanUpdate: _handleRotate,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.rotate_right, size: 18, color: Colors.white),
        ),
      ),
    );
  }
  void _handleRotate(DragUpdateDetails details) {
    final center = _widgetData.center;
    final localPosition = details.localPosition;
    final angle = (localPosition - center).direction;
    
    setState(() {
      _widgetData = _widgetData.copyWith(angle: angle);
    });
  }
}

class WidgetData {
  final Offset position;
  final Size size;
  final double angle;
  final Widget image;
  final Function onClose;

  WidgetData({
    required this.position,
    required this.size,
    required this.angle,
    required this.image,
    required this.onClose,
  });

  Offset get center => Offset(
    position.dx + size.width / 2,
    position.dy + size.height / 2,
  );

  WidgetData copyWith({
    Offset? position,
    Size? size,
    double? angle,
  }) {
    return WidgetData(
      position: position ?? this.position,
      size: size ?? this.size,
      angle: angle ?? this.angle,
      image: image,
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