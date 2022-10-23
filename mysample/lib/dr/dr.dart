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
