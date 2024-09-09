import Foundation
import UIKit

protocol OnboardingProtocol: AnyObject {
    
    func getSlides() -> [OnboardingSlide]
}
class OnboardingPresenter {
    
    private weak var view: OnboardingView?
    private var slides: [OnboardingSlide] = []
    
    init(view: OnboardingView) {
        self.view = view
        loadSlides()
    }
    
    private func loadSlides() {
        slides = [
            OnboardingSlide(title: "Amount", description: "Send money fast with simple steps. Create account, Confirmation, Payment. Simple.", image: UIImage(named: "Fast Loading")!),
            OnboardingSlide(title: "Confirmation", description: "Transfer funds instantly to friends and family worldwide, strong shield protecting money.", image: UIImage(named: "Currency")!),
            OnboardingSlide(title: "Payment", description: "Enjoy peace of mind with our secure platform. Transfer funds instantly to friends.", image: UIImage(named: "Payment")!)
        ]
    }
    
    func didScrollToPage(_ page: Int) {
        view?.updateCurrentPage(page)
    }
    
    func didTapNextButton(currentPage: Int) -> Bool {
        return currentPage == slides.count - 1
    }
}

extension OnboardingPresenter: OnboardingProtocol {
    
    func getSlides() -> [OnboardingSlide] {
        
        return self.slides
    }
}
