import Foundation

protocol ChangePasswordView: AnyObject {
    func showMessage(title: String ,message: String)
    
}
class ChangePasswordPresenter {
    weak var view: ChangePasswordView?

    init(view: ChangePasswordView) {
        self.view = view
    }

    func saveNewPassword(currentPassword: String?, newPassword: String?) {
        guard let currentPassword = currentPassword, !currentPassword.isEmpty else {
            view?.showMessage(title: "Sorry", message: "Please enter the current password.")
            return
        }
        
        guard let newPassword = newPassword, !newPassword.isEmpty else {
            view?.showMessage(title: "Sorry", message: "Please enter a new password.")
            return
        }

        // Check if new password is strong
        if !isStrongPassword(newPassword) {
            view?.showMessage(title: "Sorry", message: "Password must be at least 8 characters long, contain uppercase and lowercase letters, a number, and a special character.")
            return
        }

        if currentPassword == UserManager.shared.currentUser?.password {
            // Update the user's password
            UserManager.shared.currentUser?.password = newPassword
            UserManager.shared.saveUsersToUserDefaults() // Save updated user data
            view?.showMessage(title: "Success", message: "Password changed successfully.")
        } else {
            view?.showMessage(title: "Sorry", message: "Current password is incorrect.")
        }
    }

    private func isStrongPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+=-]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}
