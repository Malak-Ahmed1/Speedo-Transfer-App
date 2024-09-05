//
//  SignUpVC.swift
//  trial
//
//  Created by mariam labib on 30/08/2024.
//

import UIKit

extension UITextField {
    func setPadding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 34 , height: 24))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class SignUpVC: UIViewController {

   
    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPassTextField: UITextField!
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var eyeIcon2: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FullNameTextField.layer.cornerRadius = 6
        //FullNameTextField.layer.masksToBounds = true
        FullNameTextField.setPadding()
        FullNameTextField.rightView = userIcon
        FullNameTextField.rightViewMode = .always
       
        EmailTextField.rightView = emailIcon
        EmailTextField.rightViewMode = .always
        
        PasswordTextField.rightView = eyeIcon
        PasswordTextField.rightViewMode = .always
       
        ConfirmPassTextField.rightView = eyeIcon2
        ConfirmPassTextField.rightViewMode = .always
        //FullNameTextField.layer.borderColor = UIColor.darkGray.cgColor
        
       
    }
    

    @IBAction func SignUpBtn(_ sender: UIButton) {
    }
    
    @IBAction func SignInBtn(_ sender: UIButton) {
    }
    
}
