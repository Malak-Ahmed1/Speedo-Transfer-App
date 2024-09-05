//
//  ChangePasswordVC.swift
//  trial
//
//  Created by mariam labib on 01/09/2024.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var CurrentPasswordTextField: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    
    @IBOutlet weak var eyeIcon2: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CurrentPasswordTextField.rightView = eyeIcon
        CurrentPasswordTextField.rightViewMode = .always
        
        
        NewPasswordTextField.rightView = eyeIcon2
        NewPasswordTextField.rightViewMode = .always
    }
    
    @IBAction func SaveBtn(_ sender: UIButton) {
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
