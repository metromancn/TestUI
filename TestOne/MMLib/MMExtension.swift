import UIKit

//Global
func img(_ name: String) -> UIImage {
    return UIImage(named: name)!
}

func rgb(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat = 1) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
}

func hex(_ hexStr: String) -> UIColor {
    return MMColor.hexColor(hexStr)
}

//Extension
extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(_ from: Int, _ length: Int) -> String {
        let fromIndex = index(from: from)
        let toIndex = index(from: from + length)
        return String(self[fromIndex..<toIndex])
    }
}

extension UIImage {
    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
}

class MMSearchController {
    static func create(_ vc: UIViewController, _ updater: UISearchResultsUpdating, _ placeholder: String) -> UISearchController {
        let result = UISearchController(searchResultsController: nil)
        result.searchResultsUpdater = updater
        result.hidesNavigationBarDuringPresentation = false
        result.dimsBackgroundDuringPresentation = false
        result.searchBar.placeholder = placeholder
        vc.navigationItem.titleView = result.searchBar
        return result
    }
}

class MMTableView {
    static func create(_ vc: UIViewController, _ dataSource: UITableViewDataSource, _ delegate: UITableViewDelegate, _ style: UITableView.Style, _ header: UIViewController?, _ footer: UIViewController?) -> UITableView {
        let frame = MMFrame.getFull()
        let backColor = UIColor.groupTableViewBackground
        return create(vc, dataSource, delegate, frame, style, backColor, header?.view, footer?.view)
    }
    
    static func create(_ vc: UIViewController, _ dataSource: UITableViewDataSource, _ delegate: UITableViewDelegate, _ frame: CGRect, _ style: UITableView.Style, _ backColor: UIColor?, _ headerView: UIView?, _ footerView: UIView?) -> UITableView {
        let result = UITableView(frame: frame, style: style)
        result.dataSource = dataSource
        result.delegate = delegate
        //result.estimatedRowHeight = 0
        result.cellLayoutMarginsFollowReadableWidth = false
        if backColor != nil { result.backgroundColor = backColor }
        if headerView != nil { result.tableHeaderView = headerView }
        result.tableFooterView = footerView ?? UIView(frame: CGRect.zero)
        vc.view.addSubview(result)
        return result
    }
    
    static func getCell(_ tableView: UITableView, _ cellId: String, _ style: UITableViewCell.CellStyle, _ accessory: UITableViewCell.AccessoryType) -> UITableViewCell {
        let result: UITableViewCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            result = cell
        } else {
            result = UITableViewCell(style: style, reuseIdentifier: cellId)
        }
        result.accessoryType = accessory
        return result
    }
    
    static func getCell(_ vc: UIViewController, _ tableView: UITableView, _ cellId: String, _ nibName: String) -> UITableViewCell? {
        var result: UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            result = cell
        } else if let nib = Bundle.main.loadNibNamed(nibName, owner: vc, options: nil) {
            for obj in nib {
                if obj is UITableViewCell {
                    result = obj as? UITableViewCell
                    break
                }
            }
        }
        return result
    }
}

//Rotate
class MMRotateTabBarController: UITabBarController {
    override var shouldAutorotate: Bool {
        return self.selectedViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.selectedViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}

class MMRotateNavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
        return self.topViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}

class MMRotateViewController: UIViewController {
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UIDevice.current.isGeneratingDeviceOrientationNotifications {
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientationChange(notification:)), name:UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    @objc private func handleOrientationChange(notification: Notification) {
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        if statusBarOrientation.isPortrait {
            print("isPortrait")
        } else if statusBarOrientation.isLandscape {
            print("isLandscape")
        }
    }
}
