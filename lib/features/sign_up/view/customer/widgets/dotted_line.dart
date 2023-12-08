import 'package:flutter/material.dart';

class HorizontalDottedLine extends StatelessWidget {
  final Color color;

  const HorizontalDottedLine({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: CustomPaint(
        painter: HorizontalDottedLinePainter(color),
      ),
    );
  }
}

class HorizontalDottedLinePainter extends CustomPainter {
  final Color color;

  HorizontalDottedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double dashWidth = 5;
    double dashSpace = 5;
    double startX = 0;
    double endX = size.width;

    Path path = Path();
    for (double x = startX; x < endX; x += dashWidth + dashSpace) {
      path.moveTo(x, 0);
      path.lineTo(x + dashWidth, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
