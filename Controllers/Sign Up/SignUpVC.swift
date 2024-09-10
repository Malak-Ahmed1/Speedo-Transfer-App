//
//  SignUpVC.swift
//  trial
//
//  Created by mariam labib on 30/08/2024.
//

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
        self.viewModel.tryRegister(name: FullNameTextField.text, email: EmailTextField.text, pass1: PasswordTextField.text, pass2: ConfirmPassTextField.text)
    }
    
    @IBAction func SignInBtn(_ sender: UIButton) {
       
    }
    
    func saveUserToUserDefaults(user: User) {
        let defaults = UserDefaults.standard

        do {
            let encodedData = try JSONEncoder().encode(user)
            
            defaults.set(encodedData, forKey: "savedUser")
        } catch {
            print("Failed to encode user: \(error)")
        }
    }
   

    
}

extension SignUpVC {
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
    
    func goToNextScreen(user: User?) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signUp2VC = sb.instantiateViewController(withIdentifier: "SignUp2VC") as! SignUp2VC
        signUp2VC.user = user!
        self.navigationController?.pushViewController(signUp2VC, animated: true)
    }
    
}
