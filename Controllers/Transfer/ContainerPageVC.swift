import UIKit

protocol StepNavigationDelegate: AnyObject {
    func goToNextStep(currentStep: UIViewController)
    func goToPreviousStep(currentStep: UIViewController)
}

class ContainerPageVC: UIViewController, UIPageViewControllerDelegate, StepNavigationDelegate {

    var pageViewController: UIPageViewController!
    var arrContainer = [UIViewController]()
    var stepsPageControl: CustomStepControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstStepVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstStepVC") as! FirstStepVC
        let secondStepVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondStepVC") as! SecondStepVC
        let thirdStepVC = self.storyboard?.instantiateViewController(withIdentifier: "ThirdStepVC") as! ThirdStepVC
        
        firstStepVC.delegate = self
        secondStepVC.delegate = self
        thirdStepVC.delegate = self
        
        arrContainer = [firstStepVC, secondStepVC, thirdStepVC]
        
        setupPageViewController()
        setupPageControl()
    }

    private func setUpInitial() {
        guard let firstVC = arrContainer.first else {
            print("Error: arrContainer is empty or not initialized")
            return
        }
        
        guard pageViewController != nil else {
            print("Error: pageViewController is not initialized")
            return
        }
        
        guard stepsPageControl != nil else {
            print("Error: stepsPageControl is not initialized")
            return
        }
        
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        stepsPageControl.configure(steps: arrContainer.count, currentStep: 0)
    }


    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        setupPageControl()
        
        setUpInitial()
    }


    private func setupPageControl() {
        // Initialize and configure CustomStepControl
        stepsPageControl = CustomStepControl()
        stepsPageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stepsPageControl)
        
        NSLayoutConstraint.activate([
               stepsPageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
               stepsPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
               stepsPageControl.heightAnchor.constraint(equalToConstant: 50)
           ])
    }


    func goToNextStep(currentStep: UIViewController) {
        guard let currentIndex = arrContainer.firstIndex(of: currentStep) else { return }
        let nextIndex = currentIndex + 1
        guard nextIndex < arrContainer.count else { return }
       
        let nextVC = arrContainer[nextIndex]
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        
        stepsPageControl.updateStep(to: nextIndex)
    }
    
    func goToPreviousStep(currentStep: UIViewController) {
        guard let currentIndex = arrContainer.firstIndex(of: currentStep) else { return }
        let previousIndex = currentIndex - 1
        
        if currentIndex == 2 {  // if back to home
            tabBarController?.selectedIndex = 0
            setUpInitial()
            stepsPageControl.updateStep(to: 0)
            return
        }
        
        let previousVC = arrContainer[previousIndex]
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
        stepsPageControl.updateStep(to: previousIndex)
    }
    
    //  update page control
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        if transitionCompleted, let visibleViewController = pageViewController.viewControllers?.first {
            if let index = arrContainer.firstIndex(of: visibleViewController) {
                stepsPageControl.updateStep(to: index)
            }
        }
    }
}
