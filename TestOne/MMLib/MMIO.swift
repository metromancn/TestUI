import Foundation

class MMIO {
    //Read
    static func readStr(_ fileName: String) -> String {
        var result = MMConst.STR_EMPTY
        do {
            result = try String(contentsOfFile: fileName, encoding: String.Encoding.utf8)
        } catch {
            MMLog.info(["MMIO.readStr()", fileName])
        }
        return result
    }
    
    static func readInt32(_ fileName: String, itemCount: Int, rowNum: Int) -> [Int] {
        var result = [Int]()
        //
        let location = 4 * itemCount * rowNum
        let length = 4 * itemCount
        let range = NSRange(location: location, length: length)
        //
        let data = NSData(contentsOfFile: fileName)!
        var bytes = [Int32](repeating: 0, count: itemCount)
        data.getBytes(&bytes, range: range)
        //
        for i in 0..<itemCount {
            result.append(Int(bytes[i]))
        }
        return result
    }
}
