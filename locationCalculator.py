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
