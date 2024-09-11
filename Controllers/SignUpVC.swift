import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPassTextField: UITextField!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var eyeIcon2: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    var viewModel: RegistrationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegistrationPresenter(view: self)
    }
    
    @IBAction func SignUpBtn(_ sender: UIButton) {
        self.viewModel.tryRegister(name: FullNameTextField.text,
                                   email: EmailTextField.text,
                                   pass1: PasswordTextField.text,
                                   pass2: ConfirmPassTextField.text,
                                   country: nil, // No country here
                                   birthDate: nil) // No birth date here
    }
    
    @IBAction func SignInBtn(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        signInVC.modalPresentationStyle = .fullScreen  // Full-screen
        present(signInVC, animated: true)
    }
    
    func goToNextScreen(user: User) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signUp2VC = sb.instantiateViewController(withIdentifier: "SignUp2VC") as! SignUp2VC
        signUp2VC.user = user
        signUp2VC.modalPresentationStyle = .fullScreen
        present(signUp2VC, animated: true)
        
    }
}

extension SignUpVC {
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
}
