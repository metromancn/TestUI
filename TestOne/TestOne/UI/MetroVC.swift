import UIKit
import PDFKit

class MetroVC: PdfVC {
    //MetroVC
    func initMetroVC(_ frame: CGRect, _ path: String) {
        initPdfVC(frame, path)
        addObserverZoom()
    }
    
    deinit {
        removeObserverZoom(self)
    }
    
    //Observer
    var preScale: CGFloat = 0
    
    func addObserverZoom() {
        preScale = pdfView.scaleFactor
        if let scrollView = MMPdf.getScrollView(pdfView) {
            scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        }
    }
    
    func removeObserverZoom(_ observer: NSObject) {
        if preScale == 0 { return }
        if let scrollView = MMPdf.getScrollView(pdfView) {
            scrollView.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if preScale == pdfView.scaleFactor { return }
        preScale = pdfView.scaleFactor
    }
}
