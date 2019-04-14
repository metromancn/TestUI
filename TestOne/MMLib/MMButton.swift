import UIKit

class MMButton {
    //
    static func style(_ button: UIButton, image: String?, title: String, tint: UIColor, border: UIColor, back: UIColor, high: UIColor) {
        if image != nil {
            button.setImage(img(image!).withRenderingMode(.alwaysTemplate), for: .normal)
            button.setTitle(" \(title)", for: .normal)
        } else {
            button.setTitle(title, for: .normal)
        }
        button.setTitleColor(tint, for: .normal)
        button.tintColor = tint
        button.layer.borderColor = border.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true
        button.setBackgroundImage(getColorImage(button.frame.size, back), for: .normal)
        button.setBackgroundImage(getColorImage(button.frame.size, high), for: .highlighted)
    }
    
    static func style(_ button: UIButton, image: String?, title: String, back: String, high: String) {
        style(button, image: image, title: title, tint: .white, border: hex(back), back: hex(back), high: hex(high))
    }

    static func style(_ button: UIButton, _ imageName: String) {
        button.setBackgroundImage(img(imageName), for: .normal)
        button.setBackgroundImage(img("\(imageName)On"), for: .highlighted)
    }
    
    static func getColorImage(_ size: CGSize, _ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    //
    static func getFab(_ text: String, x: CGFloat, y: CGFloat) -> MMCircleButton {
        return getFab(text, frame: CGRect(x: x, y: y, width: 44, height: 44))
    }
    
    static func getFab(_ text: String, frame: CGRect) -> MMCircleButton {
        let result = MMCircleButton(frame: frame)
        result.setGoogleText(text, 20)
        return result
    }
    
    static func showBlink(_ view: UIView, _ point: CGPoint) {
        return showBlink(view, x: point.x, y: point.y)
    }
    
    static func showBlink(_ view: UIView, x: CGFloat, y: CGFloat) {
        let button = MMCircleButton(frame: CGRect(x: x - 22, y: y - 22, width: 44, height: 44))
        button.styleGreen()
        button.alpha = 0
        view.addSubview(button)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {button.alpha = 1}, completion: {(_: Bool) in
            button.showAnimate()
            button.removeFromSuperview()
        })
    }
}

class MMCircleButton: UIButton {
    var borderColor: UIColor = .white
    var borderWidth: CGFloat = 0
    var animated: Bool = false
    var highlightView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.titleLabel?.textAlignment = .center
        self.highlightView = UIView(frame: self.bounds)
        self.highlightView!.alpha = 0
        self.addSubview(self.highlightView!)
        styleBlue()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = self.bounds
        maskLayer.path = CGPath(ellipseIn: self.bounds, transform: nil)
        maskLayer.fillColor = self.borderColor.cgColor
        maskLayer.position = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        self.layer.mask = maskLayer
        self.layer.cornerRadius = self.bounds.height / 2.0
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.highlightView?.backgroundColor = self.titleLabel?.textColor.withAlphaComponent(0.5)
    }
    
    override var isHighlighted: Bool {
        set {
            if newValue {
                self.highlightAnimate()
                if self.animated {
                    self.blinkAnimate()
                }
            }
        }
        get {
            return false
        }
    }
    
    func style(backColor: UIColor, titleColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, animated: Bool) {
        self.backgroundColor = backColor
        self.setTitleColor(titleColor, for: .normal)
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.animated = animated
        self.layoutSubviews()
    }
    
    func styleBlue() {
        style(backColor: rgb(66, 133, 244), titleColor: .white, borderColor: rgb(66, 133, 244), borderWidth: 0, animated: false)
    }
    
    func styleWhite() {
        style(backColor: .white, titleColor: rgb(66, 133, 244), borderColor: .white, borderWidth: 0, animated: false)
    }
    
    func styleGreen() {
        style(backColor: rgb(0, 255, 0), titleColor: .white, borderColor: rgb(0, 255, 0), borderWidth: 0, animated: false)
    }
    
    func highlightAnimate() {
        self.highlightView!.alpha = 1
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {self.highlightView!.alpha = 0}, completion: nil)
    }
    
    func showAnimate() {
        self.highlightAnimate()
        self.blinkAnimate()
    }
    
    func blinkAnimate() {
        let pathFrame = CGRect(x: -self.bounds.midX, y: -self.bounds.midY, width: self.bounds.width, height: self.bounds.height)
        let path = UIBezierPath(roundedRect: pathFrame, cornerRadius: self.layer.cornerRadius)
        let shapePosition = self.superview?.convert(self.center, from: self.superview)
        //
        let circleShape = CAShapeLayer()
        circleShape.path = path.cgPath
        circleShape.position = shapePosition!
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.opacity = 0
        circleShape.strokeColor = self.layer.borderColor
        circleShape.lineWidth = 2.0
        self.superview?.layer.addSublayer(circleShape)
        //
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnimation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(3.0, 3.0, 1.0))
        //
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 1
        alphaAnimation.toValue = 0
        //
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, alphaAnimation]
        animation.duration = 0.7
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        circleShape.add(animation, forKey: nil)
    }
    
    func setGoogleText(_ text: String, _ size: CGFloat) {
        self.titleLabel?.font = UIFont(name: "googleicon", size: size)
        self.setTitle(text, for: .normal)
    }
    
    func setSystemText(_ text: String, _ size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        self.setTitle(text, for: .normal)
    }
}
