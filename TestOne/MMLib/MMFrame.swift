import UIKit

class MMFrame {
    //View
    static func getFull() -> CGRect {
        return getFrame(status: false, nav: false, tab: false)
    }
    
    static func getTab() -> CGRect {
        return getFrame(status: true, nav: true, tab: true)
    }
    
    static func getPresent() -> CGRect {
        return getFrame(status: true, nav: true, tab: false)
    }
    
    static func getFrame(status: Bool, nav: Bool, tab: Bool) -> CGRect {
        var result = UIScreen.main.bounds
        var up: CGFloat = 0
        var down: CGFloat = 0
        if status { up += getStatusHeight() }
        if nav { up += getNavHeight() }
        if tab { down += getTabHeight() + getBottomHeight() }
        result.origin.y += up
        result.size.height -= up + down
        return result
    }
    
    //Button
    static func getFullTR(width: CGFloat, height: CGFloat) -> CGRect {
        let space: CGFloat = 8
        let x: CGFloat = UIScreen.main.bounds.width - space - width
        let y: CGFloat = getTopHeight() + space
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    static func getFullTB(width: CGFloat, height: CGFloat) -> CGRect {
        let space: CGFloat = 8
        let x: CGFloat = UIScreen.main.bounds.width - space - width
        let y: CGFloat = UIScreen.main.bounds.height - getBottomHeight() - space - height - (MMConst.DEVICE_IS_PAD_X_SERIAL ? 34 : 0)
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    static func getTabTB(width: CGFloat, height: CGFloat) -> CGRect {
        let space: CGFloat = 8
        let x: CGFloat = UIScreen.main.bounds.width - space - width
        let y: CGFloat = UIScreen.main.bounds.height - getBottomHeight() - getTabHeight() - space - height - (MMConst.DEVICE_IS_PAD_X_SERIAL ? 34 : 0)
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    //
    static func getTopHeight() -> CGFloat {
        return MMConst.DEVICE_IS_PHONE_X_SERIAL ? 24 : 0
    }
    
    static func getStatusHeight() -> CGFloat {
        return getTopHeight() + 20
    }
    
    static func getNavHeight() -> CGFloat {
        return 44
    }
    
    static func getTabHeight() -> CGFloat {
        return 49
    }
    
    static func getBottomHeight() -> CGFloat {
        return MMConst.DEVICE_IS_PHONE_X_SERIAL ? 34 : 0
    }
}
