import Foundation

protocol RegistrationPresenterProtocol {
    func tryRegister(name: String?, email: String?, pass1: String?, pass2: String?, country: String?, birthDate: String?)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: SignUpVC!
    
    init(view: SignUpVC) {
        self.view = view
    }
    
    // Validate email format
    func isValidEmail(email: String) -> Bool {
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
    
    func isValidData(name: String?, email: String?, pass1: String?, pass2: String?, country: String?, birthDate: String?) -> Bool {
        guard let name = name?.trimmed, !name.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please enter your name!")
            return false
        }
        
        guard let email = email?.trimmed, !email.isEmpty, isValidEmail(email: email) else {
            self.view.showMessage(title: "Sorry", message: "Please enter a valid email!")
            return false
        }
        
        guard let pass1 = pass1?.trimmed, !pass1.isEmpty, isStrongPassword(password: pass1) else {
            self.view.showMessage(title: "Weak Password", message: "Your password must be at least 8 characters long, include one uppercase letter, one lowercase letter, one number, and one special character.")
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
    
    func tryRegister(name: String?, email: String?, pass1: String?, pass2: String?, country: String?, birthDate: String?) {
        if self.isValidData(name: name, email: email, pass1: pass1, pass2: pass2, country: "", birthDate: "") {
               if self.isConfirmedPassword(password: pass1!, confirmedPassword: pass2!) {
                   if !UserManager.shared.registerUser(name: name!, email: email!, password: pass1!, country: "", birthDate: "") {
                       self.view.showMessage(title: "Sorry", message: "Email is already registered!")
                   } else {
                       // Pass the user to the next screen
                       let user = User(name: name!, email: email!, password: pass1!, country: "", birthDate: "", balance: 10000, points: 0) // Create a user object
                       self.view.goToNextScreen(user: user)
                   }
               }
           }
       }
}
