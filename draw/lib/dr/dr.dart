//  将度数转换为弧度，反之亦然。
// 360° 等于 2π 弧度 因此，1° 等于 2π/360 弧度或 0.0174533 弧度
// 同样，1 弧度等于 360/2π 度
// https://www.codevscolor.com/dart-convert-degree-to-radian-vice-versa

class DR {
  // ignore: non_constant_identifier_names
  double PI = 3.14159265358979323846264338327950288419716939937510582097494459;

  double degreeToRadian(double degree) {
    return degree * PI / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / PI;
  }
}
