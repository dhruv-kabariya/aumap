import 'dart:ui';

Offset newxy(double x, double y) {
  double nx = ((y - 72.55068) / 0.0043) * 1000;
  double ny = ((x - 23.03864) / -0.00316) * 750;
  return Offset(nx, ny);
}
