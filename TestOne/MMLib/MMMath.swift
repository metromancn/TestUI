import Foundation

class MMMath {
    //LatLng
    static let EARTH_RADIUS = 6378137.0 //Unit(m)
    
    static func toRadian(_ angle: Double) -> Double {
        return angle * Double.pi / 180.0
    }
    
    static func toAngle(_ radian: Double) -> Double {
        return radian * 180.0 / Double.pi
    }
    
    static func getDistance(lat1: Double, lng1: Double, lat2 : Double, lng2: Double) -> Double {
        let radLat1 = toRadian(lat1)
        let radLng1 = toRadian(lng1)
        let radLat2 = toRadian(lat2)
        let radLng2 = toRadian(lng2)
        let a = radLat1 - radLat2
        let b = radLng1 - radLng2
        var s = 2.0 * asin(sqrt(pow(sin(a / 2.0), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b / 2.0), 2)))
        s = s * EARTH_RADIUS
        s = round(s * 100) / 100
        return s
    }
    
    static func getDistanceSimple(lat1: Double, lng1: Double, lat2 : Double, lng2: Double) -> Double {
        let a = (lat2 - lat1) * 100000
        let b = (lng2 - lng1) * 100000
        var s = sqrt(pow(a, 2) + pow(b, 2))
        s = round(s * 100) / 100
        return s
    }
    
    static func getAngle(lat1: Double, lng1: Double, lat2 : Double, lng2: Double) -> Double {
        let radLat1 = toRadian(lat1)
        let radLng1 = toRadian(lng1)
        let radLat2 = toRadian(lat2)
        let radLng2 = toRadian(lng2)
        var d = sin(radLat1) * sin(radLat2) + cos(radLat1) * cos(radLat2) * cos(radLng2 - radLng1)
        d = sqrt(1 - pow(d, 2))
        d = cos(radLat2) * sin(radLng2 - radLng1) / d
        d = toAngle(asin(d))
        d = round(d * 100) / 100
        return d
    }
    
    static func getRadianLat(lat1: Double, lng1: Double, lat2 : Double, lng2: Double) -> Double {
        let latDiff = lat2 - lat1
        let lngDiff = lng2 - lng1
        return atan2(lngDiff, latDiff)
    }
    
    static func getAngleLat(lat1: Double, lng1: Double, lat2 : Double, lng2: Double) -> Double {
        let rad = getRadianLat(lat1: lat1, lng1: lng1, lat2: lat2, lng2: lng2)
        return toAngle(rad)
    }
    
    //Point
    static func getDistance(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2))
    }
}
