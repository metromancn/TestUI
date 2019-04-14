import UIKit
import MessageUI

class MMShare {
    //Feedback Mail
    static func getFeedbackMailVC(_ delegate: MFMailComposeViewControllerDelegate, _ subject: String, _ body: String) -> MFMailComposeViewController? {
        var result: MFMailComposeViewController?
        if MFMailComposeViewController.canSendMail() {
            result = MFMailComposeViewController()
            result?.mailComposeDelegate = delegate
            result?.setToRecipients([MMConst.GMAIL])
            result?.setSubject(subject)
            result?.setMessageBody(body, isHTML: false)
        }
        return result
    }
    
    static func getScreenShot() -> UIImage? {
        var result: UIImage?
        if let layer = UIApplication.shared.keyWindow?.layer {
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
            if let context = UIGraphicsGetCurrentContext() {
                layer.render(in: context)
                result = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
        }
        return result
    }
}
