import UIKit
import PDFKit

@available(iOS 11.0, *)
class MMPdf {
    //Create
    static func createPDFView(_ vc: UIViewController, url: URL) -> NonSelectablePDFView {
        let frame = MMFrame.getFull()
        let backColor = UIColor.groupTableViewBackground
        return createPDFView(vc, frame, backColor, url)
    }
    
    static func createPDFView(_ vc: UIViewController, _ frame: CGRect, _ backColor: UIColor?, _ url: URL) -> NonSelectablePDFView {
        let result = NonSelectablePDFView(frame: frame)
        if backColor != nil { result.backgroundColor = backColor! }
        result.displaysPageBreaks = false
        result.document = PDFDocument(url: url)!
        vc.view.addSubview(result)
        return result
    }
    
    //Reset
    static func reset(_ pdfView: PDFView) {
        pdfView.minScaleFactor = getMinScale(pdfView)
        pdfView.maxScaleFactor = 4
        zoom(pdfView, 1.0)
        move(pdfView, getCenterPdfPoint(pdfView))
    }
    
    //ScrollView
    static func getScrollView(_ pdfView: PDFView) -> UIScrollView? {
        var result: UIScrollView?
        for obj in pdfView.subviews {
            if obj is UIScrollView {
                result = obj as? UIScrollView
                break
            }
        }
        return result
    }
    
    static func zoom(_ pdfView: PDFView, _ zoomScale: CGFloat) {
        if let scrollView = getScrollView(pdfView) {
            scrollView.setZoomScale(zoomScale, animated: true)
        }
    }
    
    static func move(_ pdfView: PDFView, _ pdfPoint: CGPoint) {
        if let scrollView = getScrollView(pdfView) {
            let scrollPoint = toScrollPoint(scrollView.zoomScale, pdfPoint)
            let offsetX = calcOffset(scrollView.contentSize.width, pdfView.bounds.size.width, scrollPoint.x)
            let offsetY = calcOffset(scrollView.contentSize.height, pdfView.bounds.size.height, scrollPoint.y)
            scrollView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
        }
    }
    
    static func calcOffset(_ contentLength: CGFloat, _ viewLength: CGFloat, _ scrollPointXY: CGFloat) -> CGFloat {
        var result: CGFloat = 0
        if contentLength > viewLength {
            if scrollPointXY > viewLength / 2 {
                result = scrollPointXY - viewLength / 2
            }
        }
        return result
    }
    
    static func getMinScale(_ pdfView: PDFView) -> CGFloat {
        var result: CGFloat = 0.25
        if let scrollView = getScrollView(pdfView) {
            let pdfSize = toPdfSize(scrollView.zoomScale, scrollView.contentSize)
            let widthScale = pdfView.bounds.width / pdfSize.width
            let heightScale = pdfView.bounds.height / pdfSize.height
            let scale = max(widthScale, heightScale)
            result = max(result, scale)
            result = min(result, 1.0)
        }
        return result
    }
    
    static func getPdfSize(_ pdfView: PDFView) -> CGSize {
        var result = CGSize.zero
        if let scrollView = getScrollView(pdfView) {
            result = toPdfSize(scrollView.zoomScale, scrollView.contentSize)
        }
        return result
    }
    
    static func getCenterPdfPoint(_ pdfView: PDFView) -> CGPoint {
        var x: CGFloat = 0
        var y: CGFloat = 0
        if let scrollView = getScrollView(pdfView) {
            let pdfSize = toPdfSize(scrollView.zoomScale, scrollView.contentSize)
            x = pdfSize.width / 2
            y = pdfSize.height / 2
        }
        return CGPoint(x: x, y: y)
    }
    
    //Gesture
    static func addTapGesture(_ pdfView: PDFView, _ target: Any?, _ action: Selector?, _ tapNumber: Int) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = tapNumber
        tapGesture.numberOfTouchesRequired = 1
        pdfView.addGestureRecognizer(tapGesture)
    }
    
    static func tapTwoAction(_ pdfView: PDFView) {
        let curScale = pdfView.scaleFactor
        let minScale = pdfView.minScaleFactor
        let maxScale = pdfView.maxScaleFactor
        if curScale <= minScale {
            if minScale < 1.0 {
                zoom(pdfView, 1.0)
            } else {
                zoom(pdfView, min(curScale * 2.0, maxScale))
            }
        } else if curScale >= maxScale {
            zoom(pdfView, minScale)
        } else {
            zoom(pdfView, min(curScale * 2.0, maxScale))
        }
    }
    
    //Observer
    static func addObserverZoom(_ pdfView: PDFView, _ observer: NSObject) {
        if let scrollView = getScrollView(pdfView) {
            scrollView.addObserver(observer, forKeyPath: "contentOffset", options: .new, context: nil)
        }
    }
    
    static func removeObserverZoom(_ pdfView: PDFView, _ observer: NSObject) {
        if let scrollView = getScrollView(pdfView) {
            scrollView.removeObserver(observer, forKeyPath: "contentOffset")
        }
    }
    
    //Convert
    static func toPdfPoint(_ zoomScale: CGFloat, _ point: CGPoint) -> CGPoint {
        let x = point.x / zoomScale
        let y = point.y / zoomScale
        return CGPoint(x: x, y: y)
    }
    
    static func toScrollPoint(_ zoomScale: CGFloat, _ point: CGPoint) -> CGPoint {
        let x = point.x * zoomScale
        let y = point.y * zoomScale
        return CGPoint(x: x, y: y)
    }
    
    static func toPdfSize(_ zoomScale: CGFloat, _ size: CGSize) -> CGSize {
        let width = size.width / zoomScale
        let height = size.height / zoomScale
        return CGSize(width: width, height: height)
    }
    
    static func toScrollSize(_ zoomScale: CGFloat, _ size: CGSize) -> CGSize {
        let width = size.width * zoomScale
        let height = size.height * zoomScale
        return CGSize(width: width, height: height)
    }
}

@available(iOS 11.0, *)
class NonSelectablePDFView: PDFView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer is UILongPressGestureRecognizer {
            gestureRecognizer.isEnabled = false
        }
        super.addGestureRecognizer(gestureRecognizer)
    }
}

@available(iOS 11.0, *)
class PdfVC: UIViewController {
    var pdfView: NonSelectablePDFView!
    
    func initPdfVC(_ frame: CGRect, _ path: String) {
        pdfView = MMPdf.createPDFView(self, frame, .white, URL(fileURLWithPath: path))
        MMPdf.reset(pdfView)
        MMPdf.addTapGesture(pdfView, self, #selector(tapTwo(_:)), 2)
    }
    
    @objc func tapTwo(_ sender: Any) {
        MMPdf.tapTwoAction(pdfView)
    }
}

@available(iOS 11.0, *)
class ZoomPdfVC: PdfVC {
    //Init
    func initZoomPdfVC(_ frame: CGRect, _ path: String) {
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
        MMPdf.addObserverZoom(pdfView, self)
    }
    
    func removeObserverZoom(_ observer: NSObject) {
        if preScale == 0 { return }
        MMPdf.removeObserverZoom(pdfView, self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if preScale == pdfView.scaleFactor { return }
        preScale = pdfView.scaleFactor
        refreshMarkers()
    }

    func refreshMarkers() {
    }
}

@available(iOS 11.0, *)
class FullPdfVC: PdfVC {
    var file = MMConst.STR_EMPTY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPdfVC(MMFrame.getFull(), file)
        MMCode.createCloseButton(self, #selector(clickClose(_:)))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func clickClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
