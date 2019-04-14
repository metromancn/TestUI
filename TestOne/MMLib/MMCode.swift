import UIKit
import SafariServices

class MMCode {
    //Button
    static func createCloseButton(_ vc: UIViewController, _ action: Selector) {
        let button = UIButton(type: .custom)
        button.frame = MMFrame.getFullTR(width: 32, height: 32)
        button.setImage(img("Close"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(vc, action: action, for: .touchUpInside)
        vc.view.addSubview(button)
    }
    
    static func createClearButton(_ vc: UIViewController, _ action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = MMFrame.getTabTB(width: 32, height: 32)
        button.setImage(img("Close"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(vc, action: action, for: .touchUpInside)
        vc.view.addSubview(button)
        return button
    }
    
    //NSAttributedString
    static func createAttributedString(_ text: String, _ fontSize: CGFloat, _ foregroundColor: UIColor?, _ backgroundColor: UIColor?) -> NSAttributedString {
        return createAttributedString(text: text, font: UIFont.systemFont(ofSize: fontSize), foregroundColor: foregroundColor, backgroundColor: backgroundColor)
    }
    
    static func createAttributedString(text: String, font: UIFont?, foregroundColor: UIColor?, backgroundColor: UIColor?) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: Any]()
        if font != nil { attributes[.font] = font }
        if foregroundColor != nil { attributes[.foregroundColor] = foregroundColor }
        if backgroundColor != nil { attributes[.backgroundColor] = backgroundColor }
        return NSAttributedString(string: text, attributes:attributes)
    }
    
    //IOS
    static func getBackBar() -> UIBarButtonItem {
        let result = UIBarButtonItem()
        result.title = MMConst.STR_EMPTY
        return result
    }
    
    static func openURL(_ str: String, _ vc: UIViewController? = nil) {
        if let url = URL(string: str) {
            if let vc = vc {
                let safariVC = SFSafariViewController(url: url)
                vc.present(safariVC, animated: true, completion: nil)
            } else {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
    
    //
    static func getOSLang() -> String {
        var result = MMConst.STR_EMPTY
        let lang = Locale.preferredLanguages[0].lowercased()
        if lang.hasPrefix("en") { result = "en" }
        else if lang.hasPrefix("zh") { result = lang.contains("hans") ? "cn" : "tw" }
        else if lang.hasPrefix("ja") { result = "ja" }
        else if lang.hasPrefix("ko") { result = "ko" }
        else if lang.hasPrefix("ru") { result = "ru" }
        else if lang.hasPrefix("fr") { result = "fr" }
        else if lang.hasPrefix("es") { result = "es" }
        else if lang.hasPrefix("de") { result = "de" }
        else if lang.hasPrefix("pt") { result = "pt" }
        else if lang.hasPrefix("it") { result = "it" }
        else { result = "en" }
        return result
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
