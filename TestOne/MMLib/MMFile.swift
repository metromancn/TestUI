import Foundation

class MMFile {
    //Path
    static func appPath() -> String {
        return Bundle.main.bundlePath
    }

    static func docPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    static func tempPath() -> String {
        return NSTemporaryDirectory()
    }

    static func joinPath(_ paths: String...) -> String {
        var result = paths[0]
        for i in 1..<paths.count {
            result = "\(result)\(MMConst.STR_SLASH)\(paths[i])"
        }
        return result
    }
    
    //File
    static func fileExists(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    static func createDirectory(_ path: String) {
        if !fileExists(path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    static func deleteAll(_ path: String) {
        do {
            if fileExists(path) {
                let fileList = contentsOfDirectory(path)
                for file in fileList {
                    try FileManager.default.removeItem(atPath: MMFile.joinPath(path, file))
                }
                try FileManager.default.removeItem(atPath: path)
            }
        } catch {
            MMLog.info(["MMLib.deleteAll()", path])
        }
    }

    static func contentsOfDirectory(_ path: String) -> [String] {
        var result = [String]()
        do {
            if fileExists(path) {
                result = try FileManager.default.contentsOfDirectory(atPath: path)
            }
        } catch {
            MMLog.info(["MMLib.contentsOfDirectory()", path])
        }
        return result
    }

    //Other
    static func toURL(_ path: String) -> URL {
        return URL(fileURLWithPath: path)
    }
}
