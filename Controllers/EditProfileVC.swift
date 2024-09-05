//
//  EditProfileVC.swift
//  trial
//
//  Created by mariam labib on 01/09/2024.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var BirthDateTextField: UITextField!
    @IBOutlet weak var dropDownIcon: UIImageView!
    @IBOutlet weak var vectorIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CountryTextField.rightView = dropDownIcon
        CountryTextField.rightViewMode = .always
        
        BirthDateTextField.rightView = vectorIcon
        BirthDateTextField.rightViewMode = .always
        
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
