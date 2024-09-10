import Foundation

protocol LoginPresenterProtocol {
    func tryLogin(email: String?, password: String?)
}

class LoginPresenter {
    weak var view: SignInVC!
    
    init(view: SignInVC) {
        self.view = view
    }
    
    func isValidData(email: String?, password: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please enter your email!")
            return false
        }
        
        guard let password = password?.trimmed, !password.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please enter your password!")
            return false
        }
        
        return true
    }
    
    func isAuthenticated(email: String?, password: String?) -> Bool {
        // Retrieve users from UserManager
        let users = UserManager.shared.users
        
        // Check if user exists and password matches
        for user in users {
            if user.email == email && user.password == password {
                UserManager.shared.currentUser = user
                return true
            }
        }
        
        self.view.showMessage(title: "Login Failed", message: "Incorrect email or password.")
        return false
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func tryLogin(email: String?, password: String?) {
        if self.isValidData(email: email, password: password) {
            if self.isAuthenticated(email: email, password: password) {
                self.view.goToNextScreen()
            }
        }
    }
}
