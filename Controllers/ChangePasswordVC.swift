//
//  ChangePasswordVC.swift
//  trial
//
//  Created by mariam labib on 01/09/2024.
//

import UIKit

class ChangePasswordVC: UIViewController, ChangePasswordView {

    @IBOutlet weak var CurrentPasswordTextField: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    @IBOutlet weak var eyeIcon2: UIImageView!
    @IBOutlet weak var eyeIcon: UIImageView!
    var presenter: ChangePasswordPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ChangePasswordPresenter(view: self)

        let tapGestureCurrentPassword = UITapGestureRecognizer(target: self, action: #selector(toggleCurrentPasswordVisibility))
        eyeIcon.isUserInteractionEnabled = true
        eyeIcon.addGestureRecognizer(tapGestureCurrentPassword)

        let tapGestureNewPassword = UITapGestureRecognizer(target: self, action: #selector(toggleNewPasswordVisibility))
        eyeIcon2.isUserInteractionEnabled = true
        eyeIcon2.addGestureRecognizer(tapGestureNewPassword)
    }
    
    @IBAction func SaveBtn(_ sender: UIButton) {
        let currentPassword = CurrentPasswordTextField.text
        let newPassword = NewPasswordTextField.text
        presenter?.saveNewPassword(currentPassword: currentPassword, newPassword: newPassword)
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
    @objc private func toggleCurrentPasswordVisibility() {
            CurrentPasswordTextField.isSecureTextEntry.toggle()
            // Update eye icon image based on visibility state
            updateEyeIcon(eyeIcon, isSecure: CurrentPasswordTextField.isSecureTextEntry)
        }

    @objc private func toggleNewPasswordVisibility() {
            NewPasswordTextField.isSecureTextEntry.toggle()
            // Update eye icon image based on visibility state
            updateEyeIcon(eyeIcon2, isSecure: NewPasswordTextField.isSecureTextEntry)
        }

    private func updateEyeIcon(_ eyeIcon: UIImageView, isSecure: Bool) {
            // Update the image based on whether the text field is secure or not
            let imageName = isSecure ? "eyeClosed" : "eyeOpen"
            eyeIcon.image = UIImage(named: imageName)
        }
}
