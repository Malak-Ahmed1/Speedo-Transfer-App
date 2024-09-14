import UIKit

class CustomPageControl: UIPageControl {
    
    private let dotSize: CGFloat = 16.0
    private let dotSpacing: CGFloat = 8.0

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let totalWidth = CGFloat(numberOfPages) * dotSize + CGFloat(numberOfPages - 1) * dotSpacing
        let startX = (self.bounds.width - totalWidth) / 2
        
        subviews.forEach { $0.removeFromSuperview() }
        
        for index in 0..<numberOfPages {
            let dot = createDotView(isCurrentPage: index == currentPage)
            let x = startX + CGFloat(index) * (dotSize + dotSpacing)
            dot.frame = CGRect(x: x, y: (bounds.height - dotSize) / 2, width: dotSize, height: dotSize)
            addSubview(dot)
        }
    }
    
    private func createDotView(isCurrentPage: Bool) -> UIView {
        let dot = UIView()
        dot.backgroundColor = isCurrentPage ? currentPageIndicatorTintColor : pageIndicatorTintColor
        dot.layer.cornerRadius = dotSize / 2
        return dot
    }
}
