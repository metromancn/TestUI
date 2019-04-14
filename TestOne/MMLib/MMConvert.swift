import UIKit

class MMConvert {
    //
    static func toCGFloat(str: String) -> CGFloat? {
        var result: CGFloat?
        if let d = Double(str) {
            result = CGFloat(d)
        }
        return result
    }
    
    //
    static func toKM(_ m: Int) -> String {
        let km = Double(m * 10 / 1000) / 10.0
        if km == Double(Int(km)) {
            return "\(Int(km))km"
        } else {
            return "\(km)km"
        }
    }
    
    static func toMB(_ b: Int) -> String {
        let mb = Double(b * 100 / (1024 * 1024)) / 100.0
        return "\(mb)MB"
    }
    
    static func toPercent(_ progress: Double) -> String {
        let percent = Int(progress * 100.0)
        return "\(percent)%"
    }
    
    //CGPoint
    static func pointMultiply(_ pdfPoint: CGPoint, _ scale: CGFloat) -> CGPoint {
        let x = pdfPoint.x * scale
        let y = pdfPoint.y * scale
        return CGPoint(x: x, y: y)
    }
    
    static func pointDivide(_ pngPoint: CGPoint, _ scale: CGFloat) -> CGPoint {
        let x = pngPoint.x / scale
        let y = pngPoint.y / scale
        return CGPoint(x: x, y: y)
    }
    
    //CGSize
    static func sizeMultiply(_ size: CGSize, _ scale: CGFloat) -> CGSize {
        let width = size.width * scale
        let height = size.height * scale
        return CGSize(width: width, height: height)
    }
    
    static func sizeDivide(_ size: CGSize, _ scale: CGFloat) -> CGSize {
        let width = size.width / scale
        let height = size.height / scale
        return CGSize(width: width, height: height)
    }
}
