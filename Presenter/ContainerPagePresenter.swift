//
//  ContainerPagePresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 09/09/2024.
//

import Foundation

class ContainerPagePresenter {
    private weak var view: ContainerPageView?
    private var viewControllers: [UIViewController]
    
    init(view: ContainerPageView, viewControllers: [UIViewController]) {
        self.view = view
        self.viewControllers = viewControllers
    }
    
    func initializeView() {
        guard let firstVC = viewControllers.first else {
            view?.showError("Error: No view controllers available.")
            return
        }
        view?.setInitialViewController(firstVC)
        view?.updatePageControl(to: 0)
    }
    
    func goToNextStep(currentStep: UIViewController) {
        guard let currentIndex = viewControllers.firstIndex(of: currentStep), currentIndex + 1 < viewControllers.count else {
            return
        }
        let nextVC = viewControllers[currentIndex + 1]
        view?.setInitialViewController(nextVC)
        view?.updatePageControl(to: currentIndex + 1)
    }
    
    func goToPreviousStep(currentStep: UIViewController) {
        guard let currentIndex = viewControllers.firstIndex(of: currentStep), currentIndex - 1 >= 0 else {
            return
        }
        let previousVC = viewControllers[currentIndex - 1]
        view?.setInitialViewController(previousVC)
        view?.updatePageControl(to: currentIndex - 1)
    }
    
    func backToHome() {
        view?.setInitialViewController(viewControllers.first!)
        view?.updatePageControl(to: 0)
    }
}
