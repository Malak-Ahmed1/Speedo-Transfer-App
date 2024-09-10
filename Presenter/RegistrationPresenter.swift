import Foundation

protocol RegistrationPresenterProtocol {
    func tryRegister(name: String?, email: String?, pass1: String?, pass2: String?)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: SignUpVC!
    
    init(view: SignUpVC) {
        self.view = view
    }
    
    // Validate email format
    func isValidEmail(email: String) -> Bool {
        // Simple email validation regex
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    // Check if password is strong
    func isStrongPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func isValidData(name: String?, email: String?, pass1: String?, pass2: String?) -> Bool {
        guard let name = name?.trimmed, !name.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please enter your name!")
            return false
        }
        
        guard let email = email?.trimmed, !email.isEmpty, isValidEmail(email: email) else {
            self.view.showMessage(title: "Sorry", message: "Please enter a valid email!")
            return false
        }
        
        guard let pass1 = pass1?.trimmed, !pass1.isEmpty, isStrongPassword(password: pass1) else {
            self.view.showMessage(title: "Sorry", message: "Please enter a strong password!")
            return false
        }
        
        guard let pass2 = pass2?.trimmed, !pass2.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please confirm your password!")
            return false
        }
        
        return true
    }
    
    func isConfirmedPassword(password: String, confirmedPassword: String) -> Bool {
        if password == confirmedPassword {
            return true
        }
        self.view.showMessage(title: "Sorry", message: "Passwords do not match!")
        return false
    }
    
    func getUserData(name: String?, email: String?, pass: String?) -> User {
        return User(name: name!, email: email!, password: pass!, country: nil, birthDate: nil)
    }
    
    func isEmailExists(email: String) -> Bool {
        // Retrieve existing users
        let users = UserDefaults.standard.array(forKey: "users") as? [[String: Any]] ?? []
        
        // Check if email already exists
        return users.contains(where: { ($0["email"] as? String) == email })
    }
    
    func saveUser(user: User) {
        // Retrieve existing users
        var users = UserDefaults.standard.array(forKey: "users") as? [[String: Any]] ?? []
        
        // Convert user to dictionary
        let userDict: [String: Any] = ["name": user.name, "email": user.email, "password": user.password, "country": user.country ?? "", "birthDate": user.birthDate ?? ""]
        
        // Add new user to the list
        users.append(userDict)
        
        // Save updated list to UserDefaults
        UserDefaults.standard.set(users, forKey: "users")
    }
    
    func tryRegister(name: String?, email: String?, pass1: String?, pass2: String?) {
        if self.isValidData(name: name, email: email, pass1: pass1, pass2: pass2) {
            if self.isConfirmedPassword(password: pass1!, confirmedPassword: pass2!) {
                if !self.isEmailExists(email: email!) {
                    let user = self.getUserData(name: name, email: email, pass: pass1)
                    self.saveUser(user: user)
                    self.view.goToNextScreen(user: user)
                } else {
                    self.view.showMessage(title: "Sorry", message: "Email is already registered!")
                }
            }
        }
    }
}
