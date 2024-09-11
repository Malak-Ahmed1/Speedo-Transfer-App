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
        
        guard let amountText = amount?.trimmingCharacters(in: .whitespacesAndNewlines), !amountText.isEmpty else {
            self.view?.showMessage(title: "Sorry", message: "Please enter a valid amount!")
            return false
        }
        
        // Attempt to convert the amount to a Double
        guard let amountValue = Double(amountText), amountValue > 0 else {
            self.view?.showMessage(title: "Sorry", message: "Please enter a valid amount greater than 0!")
            return false
        }
        
        // Check if recipientName is not empty
        guard let recipientNameText = recipientName?.trimmingCharacters(in: .whitespacesAndNewlines), !recipientNameText.isEmpty else {
            self.view?.showMessage(title: "Sorry", message: "Please enter a recipient name!")
            return false
        }
        
        // Check if recipientAccount is not empty
        guard let recipientAccountText = recipientAccount?.trimmingCharacters(in: .whitespacesAndNewlines), !recipientAccountText.isEmpty else {
            self.view?.showMessage(title: "Sorry", message: "Please enter recipient account!")
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
