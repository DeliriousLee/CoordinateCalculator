# CoordinateCalculator

公式计算引自 http://edwilliams.org/avform147.htm#Intro
## Use
```dart
/// pubspec.yaml
coordinate_calculator:
  git: 
    url: https://github.com/DeliriousLee/CoordinateCalculator.git
/// main.dart
import 'package:coordinate_calculator/coordinate_calculator.dart';
/// calculate result: km
/// 计算结果：km
var result = DLCoordinateManager.kilometersDistanceFrom(
                    lat1: double.parse(_originLatitude.text),
                    long1: double.parse(_originLong.text),
                    lat2: double.parse(_destLatitude.text),
                    long2: double.parse(_destLong.text));
```
## Example
<img width="300" alt="截屏2023-02-07 12 25 32" src="https://user-images.githubusercontent.com/24474112/217153386-91c91523-e9d2-46cf-8aed-c76c5f6a3fbc.png">

<img width="300" alt="截屏2023-02-07 12 25 53" src="https://user-images.githubusercontent.com/24474112/217153485-6e23d3a9-4356-42d9-bd79-2867df974570.png">
上海虹桥机场 到 北京首都国际机场 直线距离

<img src="https://user-images.githubusercontent.com/24474112/217153066-4954ecd5-7122-4e58-9ae2-c5f7c563c4c6.png" width=425sp>

## Python
locationCalculator.py
附带了python版本的计算公式
```python
#    
#    @desc : python 版本的公式计算
#    @file : locationCalculator.py
#    @date : 23/02/07 11:47
#   

import math
Earth_Radius=6378.137
def sin_square(a):
    result=math.sin(a)
    return result*result
def rad(ang):
    return math.pi*ang/180.0
#a,b参数是数组
def distance_calculate(a,b):
    lata,lnga=a[0],a[1]
    latb,lngb=b[0],b[1]

    radlata,radlnga=rad(lata),rad(lnga)
    radlatb, radlngb = rad(latb), rad(lngb)

    #纬度差
    minus_a=radlata-radlatb
    #经度差
    minus_b=radlnga-radlngb

    return 2*math.asin( math.sqrt(sin_square(minus_a/2) + math.cos(radlata)*math.cos(radlatb)*sin_square(minus_b/2)))*Earth_Radius

```

## 大圆公式

the great circle fromula reference  from http://edwilliams.org/avform147.htm#Intro
Distance between points
The great circle distance d between two points with coordinates {lat1,lon1} and {lat2,lon2} is given by:

```math
d=acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon1-lon2))
```

A mathematically equivalent formula, which is less subject to rounding error for short distances is:

```math
d=2*asin(sqrt((sin((lat1-lat2)/2))^2 + 
                 cos(lat1)*cos(lat2)*(sin((lon1-lon2)/2))^2))
```
