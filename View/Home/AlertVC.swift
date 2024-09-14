//
//  AlertVC.swift
//  trial
//
//  Created by mariam labib on 01/09/2024.
//

import UIKit

class AlertVC: UIViewController {
    @IBOutlet weak var EmailTextfield: UITextField!
    
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var xIcon: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailTextfield.rightView = emailIcon
        EmailTextfield.rightViewMode = .always
        
        PasswordTextField.rightView = eyeIcon
        PasswordTextField.rightViewMode = .always
        
    }
    

    @IBAction func SignInBtn(_ sender: UIButton) {
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
