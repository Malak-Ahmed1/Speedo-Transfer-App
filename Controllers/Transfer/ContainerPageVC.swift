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

        // Initialize view controllers
        let firstStepVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstStepVC") as! FirstStepVC
        let secondStepVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondStepVC") as! SecondStepVC
        let thirdStepVC = self.storyboard?.instantiateViewController(withIdentifier: "ThirdStepVC") as! ThirdStepVC
        
        // Set delegate for each step view controller
        firstStepVC.delegate = self
        secondStepVC.delegate = self
        thirdStepVC.delegate = self
        
        // Populate the array with view controllers
        arrContainer = [firstStepVC, secondStepVC, thirdStepVC]
        
        // Setup page view controller and page control
        setupPageViewController()
        setupPageControl()
    }
    
    func setUpInitial() {
        
        // Set FirstStepVC as the initial view controller
        if let firstVC = arrContainer.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
    }

    private func setupPageViewController() {
        // Initialize UIPageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        
        setUpInitial()

        // Add UIPageViewController as a child view controller
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }

    private func setupPageControl() {
        // Initialize and configure CustomStepControl
        stepsPageControl = CustomStepControl()
        stepsPageControl.frame = CGRect(x: 7, y: -40, width: 340, height: 340)
        stepsPageControl.configure(steps: arrContainer.count, currentStep: 0)
        // Add CustomStepControl to the view hierarchy
        view.addSubview(stepsPageControl)
        
        NSLayoutConstraint.activate([
              stepsPageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),

              stepsPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
              stepsPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),

              stepsPageControl.heightAnchor.constraint(equalToConstant: 340),
              stepsPageControl.widthAnchor.constraint(equalToConstant: 340)
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
        
           if (previousIndex < 0 || currentIndex == 2 ) {
               tabBarController?.selectedIndex = 0
               setUpInitial()
               stepsPageControl.updateStep(to: 0)
               return
           }
        
        let previousVC = arrContainer[previousIndex]
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
        stepsPageControl.updateStep(to: previousIndex)
    
    }
    
    // Implement UIPageViewControllerDelegate method to update page control
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        if transitionCompleted, let visibleViewController = pageViewController.viewControllers?.first {
            if let index = arrContainer.firstIndex(of: visibleViewController) {
                stepsPageControl.configure(steps: arrContainer.count, currentStep: index)
            }
        }
    }
 
}
