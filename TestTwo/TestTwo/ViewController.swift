import UIKit
import FloatingPanel

class ViewController: UIViewController {
    var fpc: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fpc = FloatingPanelController()
//        let semiModalViewController = SemiModalViewController()
//        fpc.set(contentViewController: semiModalViewController)
//        fpc.addPanel(toParent: self, belowView: nil, animated: false)
        
        fpc = FloatingPanelController()
        //fpc.delegate = self
        let contentVC = ContentOneVC()
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.addPanel(toParent: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fpc.removePanelFromParent(animated: true)
    }
}

class SemiModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
    }
}
