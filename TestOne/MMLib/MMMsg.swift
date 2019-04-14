import UIKit

class MMMsg {
    //
    static var okMsg = "OK"
    static var cancelMsg = "Cancel"
    static var errorMsg = "Error"
    static var failureMsg = "Failure"
    
    static func reset(cancel: String, error: String, failure: String) {
        cancelMsg = cancel
        errorMsg = error
        failureMsg = failure
    }
    
    //Message
    static func show(_ vc: UIViewController, title: String?, message: String?) {
        let alertVC = getAlert(title: title, message: message)
        alertVC.addAction(UIAlertAction(title: okMsg, style: .cancel, handler: nil))
        showAlert(vc, alertVC)
    }
    
    static func show(_ vc: UIViewController, title: String) {
        show(vc, title: title, message: nil)
    }
    
    static func show(_ vc: UIViewController, message: String) {
        show(vc, title: nil, message: message)
    }
    
    static func show(_ vc: UIViewController, fail: String) {
        show(vc, title: failureMsg, message: fail)
    }
    
    static func show(_ vc: UIViewController, error: String) {
        show(vc, title: errorMsg, message: error)
    }
    
    //Confirm
    static func showConfirm(_ vc: UIViewController, title: String?, message: String?, yesTitle: String?, noTitle: String?, yesHandler: ((UIAlertAction) -> Void)?, noHandler: ((UIAlertAction) -> Void)?) {
        let alertVC = getAlert(title: title, message: message)
        alertVC.addAction(UIAlertAction(title: yesTitle, style: .default, handler: yesHandler))
        alertVC.addAction(UIAlertAction(title: noTitle, style: .cancel, handler: noHandler))
        showAlert(vc, alertVC)
    }
    
    static func showConfirm(_ vc: UIViewController, title: String?, message: String?, yes: String?, handler: ((UIAlertAction) -> Void)?) {
        showConfirm(vc, title: title, message: message, yesTitle: yes, noTitle: cancelMsg, yesHandler: handler, noHandler: nil)
    }
    
    //Alert & ActionSheet
    static func getAlert(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    static func getActionSheet(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    static func showAlert(_ vc: UIViewController, _ alertVC: UIAlertController) {
        vc.present(alertVC, animated: true, completion: nil)
    }
}
