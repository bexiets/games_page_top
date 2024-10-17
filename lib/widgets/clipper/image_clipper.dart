
import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue 
      ..style = PaintingStyle.fill;

 
    final path = Path()
      ..moveTo(0, size.height) // Start at the bottom left
      ..lineTo(0, 0) // Go to the top left
      ..lineTo(size.width, 0) // Go to the top right
      ..lineTo(size.width, size.height) // Go to the bottom right
      ..lineTo(size.width - 20, size.height) // Adjust for the bottom right corner
      ..lineTo(size.width - 20, 20) // Move to top right with curve
      ..arcToPoint(Offset(size.width, 0), radius: Radius.circular(20), clockwise: false) // Curve to top right
      ..lineTo(size.width, 0) // Close the path back to top right
      ..close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; 
  }
}