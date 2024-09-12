//
//  SignUp2VC.swift
//  trial
//
//  Created by mariam labib on 31/08/2024.
//

import UIKit

class SignUp2VC: UIViewController {

    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var BirthDateTextField: UITextField!
    @IBOutlet weak var DropDownIcon: UIImageView!
    @IBOutlet weak var VectorIcon: UIImageView!
    var viewModel: SecondRegistrationPresenterProtocol!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel = SecondRegistrationPresenter(view: self, user: user)
        //print("User received in SecondViewController: \(String(describing: user))")
        
        if let user = user {
            viewModel = SecondRegistrationPresenter(view: self, user: user)
            print("User received in SecondViewController: \(user)")
        } else {
            print("Error: User is nil")
            // Handle this case if user is nil
        }
    }
    

    @IBAction func ContinueBtn(_ sender: UIButton) {
        self.viewModel?.tryRegister(country: CountryTextField.text, birthDate: BirthDateTextField.text)
    }
    @IBAction func SignInBtn(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC")
        navigationController?.pushViewController(signInVC, animated: true)
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

extension SignUp2VC {
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
    
    func goToNextScreen(user: User?) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        //SignInVC.user = user!
        //self.present(logicVC, animated: true)
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
}
