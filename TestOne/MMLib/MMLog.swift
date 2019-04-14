import UIKit

class MMLog {
    //TODO
    static let debugFlag = true

    //Info
    static func info(_ text: String) {
        if debugFlag {
            print(text)
        }
    }

    static func info(_ textList: [String]) {
        let log = MMStr.joinRow(textList)
        info(log)
    }

    //Error
    static func error(_ text: String?, _ error: Error?) {
        var logList = [String]()
        if let text = text {
            logList.append(text)
        }
        if let error = error {
            logList.append("\(error)")
        }
        let log = MMStr.joinRow(logList)
        info(log)
    }
}
