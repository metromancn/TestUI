import UIKit

class MainVC: PopMetroVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.groupTableViewBackground
        initMetroVC(MMFrame.getFrame(status: false, nav: false, tab: true), MMFile.joinPath(MMFile.appPath(), "routemap_sh_cn.pdf"))
        //MMPdf.zoom(self.pdfView, 1.0)
    }
}
