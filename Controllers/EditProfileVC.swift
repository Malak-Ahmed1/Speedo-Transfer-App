//
//  EditProfileVC.swift
//  trial
//
//  Created by mariam labib on 01/09/2024.
//

import UIKit

class EditProfileVC: UIViewController, EditProfileView {

    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var BirthDateTextField: UITextField!
    @IBOutlet weak var dropDownIcon: UIImageView!
    @IBOutlet weak var vectorIcon: UIImageView!
    var presenter: EditProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EditProfilePresenter(view: self)
        presenter?.viewDidLoad()
    }
    
    @IBAction func SaveBtn(_ sender: UIButton) {
        presenter?.saveChanges(
                    fullName: FullNameTextField.text,
                    email: EmailTextField.text,
                    country: CountryTextField.text,
                    birthDate: BirthDateTextField.text
                )
    }
    
    func updateUserInfo(fullName: String, email: String, country: String, birthDate: String) {
        FullNameTextField.text = fullName
        EmailTextField.text = email
        CountryTextField.text = country
        BirthDateTextField.text = birthDate
        }
        
        func showSuccessMessage(_ message: String) {
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        func showErrorMessage(_ message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}
