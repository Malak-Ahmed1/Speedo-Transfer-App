import UIKit

protocol FirstStepPresenterProtocol {
    func continueButtonTapped()
    func backButtonTapped()
    func favouriteButtonTapped()
}

class FirstStepPresenter: FirstStepPresenterProtocol {
    private weak var view: FirstStepViewProtocol?
    private var stepNavigationDelegate: StepNavigationDelegate?

    init(view: FirstStepViewProtocol, stepNavigationDelegate: StepNavigationDelegate?) {
        self.view = view
        self.stepNavigationDelegate = stepNavigationDelegate
    }

    func continueButtonTapped() {
        if let viewController = view as? UIViewController {
            stepNavigationDelegate?.goToNextStep(currentStep: viewController)
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
