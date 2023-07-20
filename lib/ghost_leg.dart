import 'dart:ffi';
import 'dart:math';

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
}
