import UIKit

class CustomStepControl: UIPageControl {

    private var circleImages: [UIImageView] = []
    private var trailers: [UIImageView] = []
    private var titles: [UILabel] = []

    private let titlesArray = ["Amount", "Confirmation", "Payment"]
    private let imagesArray = ["step1", "step2", "step3"]

    private let titleFont = UIFont.systemFont(ofSize: 14, weight: .bold)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        self.isUserInteractionEnabled = false
        setupCustomSubviews()
        configure(steps: titlesArray.count, currentStep: 0)
    }

    private func setupCustomSubviews() {
        for i in 0..<titlesArray.count {
            let circleImageView = UIImageView()
            circleImageView.contentMode = .scaleAspectFit
            circleImages.append(circleImageView)
            self.addSubview(circleImageView)

            if i < titlesArray.count - 1 {
                let trailerImageView = UIImageView()
                trailerImageView.contentMode = .scaleAspectFit
                trailers.append(trailerImageView)
                self.addSubview(trailerImageView)
            }

            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.font = titleFont
            titles.append(titleLabel)
            self.addSubview(titleLabel)
        }

        layoutCustomSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCustomSubviews()
        
    }
  
    private func layoutCustomSubviews() {
        let circleSize: CGFloat = 35.77
        let trailerWidth: CGFloat = 85
        let trailerHeight: CGFloat = 24
        let spacing: CGFloat = 8
        
        // Calculate the total width required
        let totalWidth = CGFloat(circleImages.count) * circleSize + CGFloat(trailers.count) * trailerWidth + CGFloat(circleImages.count - 1) * spacing
        
        // Start layout from the center of the control
        var currentX = (self.bounds.width - totalWidth) / 2
        
        for i in 0..<circleImages.count {
            let circleImageView = circleImages[i]
            let titleLabel = titles[i]
            
            // Position the circle images
            circleImageView.frame = CGRect(x: currentX, y: 0, width: circleSize, height: circleSize)
            circleImageView.center.y = self.bounds.midY - 10
            
            // Position the titles under each circle
            titleLabel.frame = CGRect(x: currentX - 30, y: circleImageView.frame.maxY + 18.77, width: 100, height: 20)
            
            currentX += circleSize + spacing
            
            if i < trailers.count {
                let trailerImageView = trailers[i]
                trailerImageView.frame = CGRect(x: currentX, y: 0, width: trailerWidth, height: trailerHeight)
                trailerImageView.center.y = circleImageView.center.y
                
                currentX += trailerWidth + spacing
            }
        }
    }

    func configure(steps: Int, currentStep: Int) {
        self.numberOfPages = 0
        updateStep(to: currentStep)
    }

    func updateStep(to index: Int) {
        for (i, imageView) in circleImages.enumerated() {
            let imageName = i < imagesArray.count ? imagesArray[i] : ""
            
            if i <= index {
                imageView.image = UIImage(named: "\(imageName)Filled")
            } else {
                imageView.image = UIImage(named: "\(imageName)NonFilled")
            }
            
            titles[i].text = i < titlesArray.count ? titlesArray[i] : ""
                   titles[i].font = i == index ? UIFont.boldSystemFont(ofSize: 14) : UIFont.systemFont(ofSize: 14)
        }

        for i in 0..<trailers.count {
            trailers[i].image = UIImage(named: i < index ? "trailerFilled" : "trailerNonFilled")
        }
    }
}
