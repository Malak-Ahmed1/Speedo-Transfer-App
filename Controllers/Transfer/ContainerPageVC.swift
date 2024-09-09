import UIKit

protocol StepNavigationDelegate: AnyObject {
    func goToNextStep(currentStep: UIViewController)
    func goToPreviousStep(currentStep: UIViewController)
}

protocol ContainerPageView: AnyObject {
    func updatePageControl(to step: Int)
    func setInitialViewController(_ viewController: UIViewController)
    func showError(_ message: String)
}

import UIKit

class ContainerPageVC: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController!
    var stepsPageControl: CustomStepControl!
    private var presenter: ContainerPagePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstStepVC = storyboard?.instantiateViewController(withIdentifier: "FirstStepVC") as! FirstStepVC
        let secondStepVC = storyboard?.instantiateViewController(withIdentifier: "SecondStepVC") as! SecondStepVC
        let thirdStepVC = storyboard?.instantiateViewController(withIdentifier: "ThirdStepVC") as! ThirdStepVC
        
        let viewControllers = [firstStepVC, secondStepVC, thirdStepVC]
        
        firstStepVC.delegate = self
        secondStepVC.delegate = self
        thirdStepVC.delegate = self
        
        presenter = ContainerPagePresenter(view: self, viewControllers: viewControllers)
        
        setupPageViewController()
        setupPageControl()
        presenter.initializeView()
    }

    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }

    private func setupPageControl() {
        stepsPageControl = CustomStepControl()
        stepsPageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stepsPageControl)
        
        NSLayoutConstraint.activate([
            stepsPageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            stepsPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepsPageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
   
    func backToHome() {
        presenter.backToHome()
    }
    
    
    
    
}

extension ContainerPageVC: ContainerPageView, StepNavigationDelegate {
    // MARK: - ContainerPageView Protocol Methods

    func updatePageControl(to step: Int) {
        stepsPageControl.updateStep(to: step)
    }
    
    func setInitialViewController(_ viewController: UIViewController) {
        pageViewController.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
    
    func showError(_ message: String) {
        // Handle error display if needed
        print(message)
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        if transitionCompleted, let visibleViewController = pageViewController.viewControllers?.first {
            if let index = presenter.viewControllers.firstIndex(of: visibleViewController) {
                stepsPageControl.updateStep(to: index)
            }
        }
    }
    func goToNextStep(currentStep: UIViewController) {
        presenter.goToNextStep(currentStep: currentStep)
    }
    
    func goToPreviousStep(currentStep: UIViewController) {
        if let currentIndex = presenter.viewControllers.firstIndex(of: currentStep), currentIndex == 2 {
            backToHome()
        } else {
            presenter.goToPreviousStep(currentStep: currentStep)
        }
    }

    
}


