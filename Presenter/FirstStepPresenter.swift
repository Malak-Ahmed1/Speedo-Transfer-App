import UIKit

protocol FirstStepPresenterProtocol {
    func continueButtonTapped(amount: String?, recipientName: String?, recipientAccount: String?)
    func backButtonTapped()
    func favouriteButtonTapped()
}

class FirstStepPresenter {
    private weak var view: FirstStepViewProtocol?
    private var stepNavigationDelegate: StepNavigationDelegate?
    
    init(view: FirstStepViewProtocol, stepNavigationDelegate: StepNavigationDelegate?) {
        self.view = view
        self.stepNavigationDelegate = stepNavigationDelegate
    }
    func isValidData(amount: String?, recipientName: String?, recipientAccount: String?) -> Bool {
        
        // To.Do: check if amount > 0 && <= user.amount
        guard amount?.trimmed != "" else {
            self.view?.showMessage(title: "Sorry", message: "Please enter a valid amount!")
            return false
        }
        
        guard recipientName?.trimmed != "" else {
            self.view?.showMessage(title: "Sorry", message: "Please enter arecipient name!")
            return false
        }
        
        guard recipientAccount?.trimmed != "" else {
            self.view?.showMessage(title: "Sorry", message: "Please enter recipient Account!")
            return false
        }
        
        return true
    }
    
    
    
}
extension FirstStepPresenter: FirstStepPresenterProtocol {
    
    func continueButtonTapped(amount: String?, recipientName: String?, recipientAccount: String?) {
        if isValidData(amount: amount, recipientName: recipientName, recipientAccount: recipientAccount) {
            if let viewController = view as? UIViewController {
                
                stepNavigationDelegate?.goToNextStep(currentStep: viewController)
            }
        } else {
            return
        }
    }


    
    func backButtonTapped() {
        if let viewController = view as? UIViewController {
            stepNavigationDelegate?.goToPreviousStep(currentStep: viewController)
        }
    }
    
    func favouriteButtonTapped() {
        view?.showFavourites()
    }
}
