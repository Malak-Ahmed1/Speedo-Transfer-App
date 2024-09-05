//
//  SignInVC.swift
//  trial
//
//  Created by mariam labib on 31/08/2024.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        EmailTextField.rightView = EmailIcon
        EmailTextField.rightViewMode = .always
        
        PasswordTextField.rightView = eyeIcon
        PasswordTextField.rightViewMode = .always
        
    }
    

    @IBAction func SignInBtn(_ sender: UIButton) {
    }
    @IBAction func SignUpBtn(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
