import UIKit
import FloatingPanel

class ViewController: UIViewController {
    var floatingPanelController: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingPanelController = FloatingPanelController()
        let semiModalViewController = SemiModalViewController()
        floatingPanelController.set(contentViewController: semiModalViewController)
        floatingPanelController.addPanel(toParent: self, belowView: nil, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        floatingPanelController.removePanelFromParent(animated: true)
    }
}

class SemiModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
    }
}
