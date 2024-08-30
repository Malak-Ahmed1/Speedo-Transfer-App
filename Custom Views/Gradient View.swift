import UIKit

@IBDesignable
class GradientView: UIView {

    // Default colors used across all screens
    @IBInspectable var startColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var endColor: UIColor = UIColor(red: 255/255, green: 234/255, blue: 238/255, alpha: 1) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            updateView()
        }
    }

    private var gradientLayer: CAGradientLayer?

    private func updateView() {
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer!.frame = bounds
            layer.insertSublayer(gradientLayer!, at: 0)
        }
        gradientLayer!.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer!.startPoint = startPoint
        gradientLayer!.endPoint = endPoint
        gradientLayer!.frame = bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
}
