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
    
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
    @objc private func toggleCurrentPasswordVisibility() {
            CurrentPasswordTextField.isSecureTextEntry.toggle()
            updateEyeIcon(eyeIcon, isSecure: CurrentPasswordTextField.isSecureTextEntry)
        }

    @objc private func toggleNewPasswordVisibility() {
            NewPasswordTextField.isSecureTextEntry.toggle()
            updateEyeIcon(eyeIcon2, isSecure: NewPasswordTextField.isSecureTextEntry)
        }

    private func updateEyeIcon(_ eyeIcon: UIImageView, isSecure: Bool) {
            let imageName = isSecure ? "eye" : "eye"
            eyeIcon.image = UIImage(named: imageName)
        }
}
