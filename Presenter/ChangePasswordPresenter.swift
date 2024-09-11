//
//  ChangePasswordPresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 11/09/2024.
//

import Foundation

protocol ChangePasswordView: AnyObject {
    func showSuccessMessage(_ message: String)
    func showErrorMessage(_ message: String)
}

class ChangePasswordPresenter {
    weak var view: ChangePasswordView?

    init(view: ChangePasswordView) {
        self.view = view
    }

    func saveNewPassword(currentPassword: String?, newPassword: String?) {
        guard let currentPassword = currentPassword, !currentPassword.isEmpty else {
            view?.showErrorMessage("Please enter the current password.")
            return
        }
        
        guard let newPassword = newPassword, !newPassword.isEmpty else {
            view?.showErrorMessage("Please enter a new password.")
            return
        }

        // Simulate password change logic
        if currentPassword == "123456" { // For example, the old password is hardcoded here
            // Assume password was changed successfully
            view?.showSuccessMessage("Password changed successfully.")
        } else {
            view?.showErrorMessage("Current password is incorrect.")
        }
    }
}
