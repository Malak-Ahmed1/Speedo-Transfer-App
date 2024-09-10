import UIKit

class CustomProgressBar: UIProgressView {

    // Custom initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup method for initial styling
    private func setup() {
        self.trackTintColor = UIColor.lightGray
        self.progressTintColor = UIColor.customPink // Ensure customPink is defined in your UIColor extension

        self.layer.cornerRadius = 4
        self.clipsToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }

    // MARK: - Set gradient color for progress bar
    func setGradientColors(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds

        // Ensure only one gradient layer is applied
        if let existingGradientLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingGradientLayer.removeFromSuperlayer()
        }

        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Custom animated progress
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        UIView.animate(withDuration: duration, animations: {
            self.setProgress(value, animated: false)
        })
    }
}
