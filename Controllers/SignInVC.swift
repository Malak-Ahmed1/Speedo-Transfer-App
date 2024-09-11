import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    
    var user: User?
    var loginPresenterProtocol: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the presenter
        loginPresenterProtocol = LoginPresenter(view: self)
    }
    
    @IBAction func SignInBtn(_ sender: UIButton) {
        self.loginPresenterProtocol.tryLogin(email: EmailTextField.text, password: PasswordTextField.text)
    }
    
    @IBAction func SignUpBtn(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signUpVC = sb.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
    }
    
    func goToNextScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
       
        if let tabBarController = storyboard.instantiateInitialViewController() as? UITabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController = tabBarController
        }
    }
}

extension SignInVC {
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
}
