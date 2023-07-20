import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

// make class ghost_leg
class Point {
  double x;
  double y;

  Point(this.x, this.y);
}

class GhostLeg {
  List<Point> legs = [];

  //generate random number
  double randomX(int max, double size) {
    var intValue = Random().nextInt(max);
    var width = size / max.toDouble();
    return intValue.toDouble() * width;
  }

  double randomY(int max, double size) {
    var intValue = Random().nextInt(max);
    var height = size / max.toDouble();
    return intValue.toDouble() * height;
  }

  // 사다리의 다리를 만드는 함수
  List<Point> makeLegs(double width, double height, playerNum, legCount) {
    var maxLevel = 50;

    // 깊이 중복을 막기위해  y 축의 값이용
    List<double> depthList = [];
    for (int i = 0; i < legCount; i++) {
      double x = randomX(playerNum, width);
      double y = randomY(maxLevel, height);

      if (y == 0) {
        i--;
        continue;
      }
      if (y == height) {
        i--;
        continue;
      }

      if (depthList.contains(y)) {
        i--;
        continue;
      } else {
        legs.add(Point(x, y));
        var x2 = x + (width / playerNum);
        legs.add(Point(x2, y));
        depthList.add(y);
      }
    }

    // remove duplicate when x is same

    legs = legs.toSet().toList();
    legs.sort((a, b) => a.y.compareTo(b.y));
    return legs;
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

  void drawLegs(Canvas canvas, List<Point> legs, var playerNum, double width,
      double height, Paint lines) {
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
        Offset(i * width, height),
        lines,
      );
    }
  }
}
