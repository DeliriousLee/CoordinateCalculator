//    
//    @desc : 
//    @file : dlcoordinate_calculator.dart
//    @date : 23/02/07 11:41
//   
// ignore_for_file: non_constant_identifier_names

import 'dart:math';

class DLCoordinateManager {
//=================================================
//  property
  ///地球 半径
  static const double earthRadius = 6378.137;
//=================================================
  // 大圆公式:great circle formulae
  /// 两点之间 距离公式
  /// 返回: km
  static double kilometersDistanceFrom(
      {required double lat1,
      required double long1,
      required double lat2,
      required double long2}) {
    double radlat1 = radiusAngle(lat1);
    double radlong1 = radiusAngle(long1);
    double radlat2 = radiusAngle(lat2);
    double radlong2 = radiusAngle(long2);

    //纬度差
    double minus_latitude = radlat1 - radlat2;
    //经度差
    double minus_longtitude = radlong1 - radlong2;
    return 2 *
        asin(sqrt(sin_quare(minus_latitude / 2.0) +
            cos(radlat1) * cos(radlat2) * sin_quare(minus_longtitude / 2.0))) *
        earthRadius;
  }

  /// sin的平方
  /// the power of sin(x)
  static double sin_quare(double a) {
    return sin(a) * sin(a);
  }

  /// 角度->弧度
  static double radiusAngle(double angle) {
    return pi * angle / 180.0;
  }

//=================================================
}
