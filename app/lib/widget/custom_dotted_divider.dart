import 'package:flutter/material.dart';
import 'package:intergrate_cafe/util/color.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DottedLine({
    this.height = 1.0,
    this.color = Colors.black,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: DottedLinePainter(color, dashWidth, dashSpace),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DottedLinePainter(this.color, this.dashWidth, this.dashSpace);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double distance = dashWidth + dashSpace;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += distance;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Dotted Divider Example')),
      body: Column(
        children: [
          Text('Above the dotted line'),
          DottedLine(height: 1.0, color: ColorH.main()),
          Text('Below the dotted line'),
        ],
      ),
    ),
  ));
}
