import 'package:flutter/material.dart';

import 'ghost_leg.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var TotalPlayerNum = 5;
    var legCount = 15;

    final linePaint = Paint()
      ..color = Color.fromARGB(255, 238, 239, 233) // 선의 색
      ..strokeCap = StrokeCap.round // 선의 stroke를 둥글게
      ..strokeWidth = 10; // 선의 굵기

    final playerPaint = Paint()
      ..color = Colors.redAccent // 선의 색
      ..strokeCap = StrokeCap.round // 선의 stroke를 둥글게
      ..strokeWidth = 5; // 선의 굵기

    final playerPaint2 = Paint()
      ..color = Color.fromARGB(255, 57, 155, 22) // 선의 색
      ..strokeCap = StrokeCap.round // 선의 stroke를 둥글게
      ..strokeWidth = 5; // 선의 굵기

    if (TotalPlayerNum > 1) {
      TotalPlayerNum--;
    }

    GhostLeg ghostLeg = GhostLeg();
    List<Point> legs =
        ghostLeg.makeLegs(size.width, size.height, TotalPlayerNum, legCount);

    double width = size.width / TotalPlayerNum;

    ghostLeg.drawLegs(
        canvas, legs, TotalPlayerNum, width, size.height, linePaint);

    List<Point> playerLines =
        ghostLeg.makeLegDraw(0, TotalPlayerNum, legs, width, size.height);

    ghostLeg.drawPlayerLine(canvas, playerLines, playerPaint);

    List<Point> playerLines2 =
        ghostLeg.makeLegDraw(1, TotalPlayerNum, legs, width, size.height);

    ghostLeg.drawPlayerLine(canvas, playerLines2, playerPaint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
