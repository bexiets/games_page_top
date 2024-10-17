import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double min;
  final double max;
  final double initialValue;
  final double sliderWidth;
  final double sliderHeight; 

  const CustomSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.initialValue,
    this.sliderWidth = 270.0,
    this.sliderHeight = 2.0, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(sliderWidth, sliderHeight + 20), 
      painter: SliderPainter(currentValue: initialValue, min: min, max: max, sliderHeight: sliderHeight),
    );
  }
}

class SliderPainter extends CustomPainter {
  final double currentValue;
  final double min;
  final double max;
  final double sliderHeight;

  SliderPainter({
    required this.currentValue,
    required this.min,
    required this.max,
    required this.sliderHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint activePaint = Paint()
      ..color = Colors.white 
      ..style = PaintingStyle.fill;

    final Paint inactivePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;


    canvas.drawRect(Rect.fromLTWH(0, (size.height - sliderHeight) / 2, size.width, sliderHeight), inactivePaint);


    double activeWidth = ((currentValue - min) / (max - min)) * size.width;

    
    canvas.drawRect(Rect.fromLTWH(0, (size.height - sliderHeight) / 2, activeWidth, sliderHeight), activePaint);

  
    final double startDotSize = currentValue == min ? 6 : 6; 
    canvas.drawCircle(Offset(0, size.height / 2), startDotSize, activePaint);

    
    final double endDotSize = currentValue == max ? 6 : 3; 
    canvas.drawCircle(Offset(size.width, size.height / 2), endDotSize, activePaint);


    final Paint indicatorPaint = Paint()
      ..color = Colors.white 
      ..style = PaintingStyle.fill;
    double indicatorX = activeWidth; 
    canvas.drawCircle(Offset(indicatorX, size.height / 2), 16, indicatorPaint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: currentValue.round().toString(), 
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
                 
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    double textX = indicatorX - (textPainter.width / 2);
    double textY = (size.height / 2) - (textPainter.height / 2);

    textPainter.paint(canvas, Offset(textX, textY));


    TextPainter minTextPainter = TextPainter(
      text: TextSpan(
        text: min.round().toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500 
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    minTextPainter.layout();

    
    double minTextX = 0 - (minTextPainter.width / 2);
    double minTextY = (size.height / 2) + 10; 

    minTextPainter.paint(canvas, Offset(minTextX, minTextY));
    
  }

  @override
  bool shouldRepaint(SliderPainter oldDelegate) {
    return oldDelegate.currentValue != currentValue;
  }
}


