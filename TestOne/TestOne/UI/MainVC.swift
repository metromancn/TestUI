import UIKit

class MainVC: PopMetroVC {
    var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.groupTableViewBackground
        initMetroVC(MMFrame.getFrame(status: false, nav: false, tab: true), MMFile.joinPath(MMFile.appPath(), "routemap_sh_cn.pdf"))
        //
        view1 = UIView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height))
        view1.backgroundColor = UIColor.blue
        view.addSubview(view1)
    }
}
