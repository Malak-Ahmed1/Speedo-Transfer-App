//
//  ContainerPagePresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 09/09/2024.
//

import Foundation
import UIKit

protocol ContainerPageProtocol: AnyObject {
    
    func initializeView()
    func getVC() -> [UIViewController]
    func goToNextStep(currentStep: UIViewController)
    func goToPreviousStep(currentStep: UIViewController)
    
}
class ContainerPagePresenter {
    private weak var view: ContainerPageView?
    private var viewControllers: [UIViewController]
    
    init(view: ContainerPageView, viewControllers: [UIViewController]) {
        self.view = view
        self.viewControllers = viewControllers
    }
    
    
    
    private func backToHome() {
        view?.setInitialViewController(viewControllers.first!)
        view?.updatePageControl(to: 0)
        
    }
}

extension ContainerPagePresenter: ContainerPageProtocol {
    
    
    
    func initializeView() {
        guard let firstVC = viewControllers.first else {
            view?.showError("Error: No view controllers available.")
            return
        }
        view?.setInitialViewController(firstVC)
        view?.updatePageControl(to: 0)
    }
    func getVC() -> [UIViewController] {
        return viewControllers
    }
    func goToNextStep(currentStep: UIViewController) {
        guard let currentIndex = viewControllers.firstIndex(of: currentStep), currentIndex + 1 < viewControllers.count else {
            return
        }
        let nextVC = viewControllers[currentIndex + 1]
        
        if let secondStepVC = nextVC as? SecondStepVC {
            if let firstStepVC = currentStep as? FirstStepVC {
                secondStepVC.setupTransactionInfo(amount: firstStepVC.amountTextField.text,
                                                  recipientName: firstStepVC.recipientNameTextField.text,
                                                  recipientAccount: firstStepVC.recipientAccountTextField.text)
            }
        }
        
        if let thirdStepVC = nextVC as? ThirdStepVC {
            if let secondStepVC = currentStep as? SecondStepVC {
                thirdStepVC.setupTransactionInfo(amount: secondStepVC.firstAmountLabel.text,
                                                 recipientName: secondStepVC.recipientNameLabel.text,
                                                 recipientAccount: secondStepVC.recipientAccountLabel.text)
            }
        }
        
        view?.setInitialViewController(nextVC)
        view?.updatePageControl(to: currentIndex + 1)
    }
    
    
    
    func goToPreviousStep(currentStep: UIViewController) {
        guard let currentIndex = viewControllers.firstIndex(of: currentStep), currentIndex - 1 >= 0 else {
            return
        }
        if currentIndex == 2 || currentIndex == 0 {
            
            backToHome()
        }
        else {
            let previousVC = viewControllers[currentIndex - 1]
            view?.setInitialViewController(previousVC)
            view?.updatePageControl(to: currentIndex - 1)
        }
    }
}
