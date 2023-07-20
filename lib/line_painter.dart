import 'package:flutter/material.dart';

import 'ghost_leg.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var TotalPlayerNum = 3;
    var legCount = 10;

    final linePaint = Paint()
      ..color = Colors.amber // 선의 색
      ..strokeCap = StrokeCap.round // 선의 stroke를 둥글게
      ..strokeWidth = 10; // 선의 굵기

    final playerPaint = Paint()
      ..color = Colors.redAccent // 선의 색
      ..strokeCap = StrokeCap.round // 선의 stroke를 둥글게
      ..strokeWidth = 5; // 선의 굵기

    if (TotalPlayerNum > 1) {
      TotalPlayerNum--;
    }

    GhostLeg ghostLeg = GhostLeg();
    List<Point> legs =
        ghostLeg.makeLegs(size.width, size.height, TotalPlayerNum, legCount);

    double width = size.width / TotalPlayerNum;

    drawLegs(canvas, legs, TotalPlayerNum, width, size, linePaint);

    List<Point> playerLines =
        makeLegDraw(0, TotalPlayerNum, legs, width, size.height);

    drawPlayerLine(canvas, playerLines, playerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawLegs(Canvas canvas, List<Point> legs, var playerNum, double width,
      Size size, Paint lines) {
    //세로 라인
    for (var i = 0; i < legs.length; i += 2) {
      var x1 = 0.0;
      var x2 = 0.0;
      if (legs[i].x > legs[i + 1].x) {
        x1 = legs[i].x;
        x2 = legs[i + 1].x;
      } else {
        x1 = legs[i + 1].x;
        x2 = legs[i].x;
      }

      canvas.drawLine(
        // a점의 (x, y)
        Offset(x1, legs[i].y),
        // b점의 (x, y)
        Offset(x2, legs[i].y),
        lines,
      );
    }

    for (var i = 0; i <= playerNum; i++) {
      canvas.drawLine(
        // a점의 (x, y)
        Offset(i * width, 0),
        // b점의 (x, y)
        Offset(i * width, size.height),
        lines,
      );
    }
  }

  void drawPlayerLine(Canvas canvas, List<Point> playerLine, Paint linePaint) {
    var x = 0.0;
    var y = 0.0;

    for (var i = 0; i < playerLine.length - 1; i++) {
      canvas.drawLine(
        Offset(playerLine[i].x, playerLine[i].y),
        Offset(playerLine[i + 1].x, playerLine[i + 1].y),
        linePaint,
      );
    }
  }

  List<Point> makeLegDraw(int currentPlayerNum, int totalPlayerNum,
      List<Point> legs, double width, double height) {
    List<Point> result = [];

    Point curPoint = Point(currentPlayerNum * width, 0);
    result.add(curPoint);

    var lastY = 0.0;
    //for 반복 legs
    for (var i = 0; i < legs.length; i += 2) {
      var x1 = legs[i].x;
      var y1 = legs[i].y;
      var x2 = legs[i + 1].x;
      var y2 = legs[i + 1].y;
      if (curPoint.x == x1) {
        curPoint = Point(x1, y1);
        result.add(curPoint);
        curPoint = Point(x2, y2);
        result.add(curPoint);
      } else if (curPoint.x == x2) {
        curPoint = Point(x2, y2);
        result.add(curPoint);
        curPoint = Point(x1, y1);
        result.add(curPoint);
      }
    }

    curPoint = Point(curPoint.x, height);
    result.add(curPoint);

    return result;
  }
}
