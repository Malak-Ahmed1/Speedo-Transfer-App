//
//  LoginPresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 10/09/2024.
//

import Foundation

protocol LoginPresenterProtocol {
    func tryLogin(email: String?, password: String?)
}

class LoginPresenter {
    weak var view: SignInVC!
    
    init(view: SignInVC) {
        self.view = view
    }
    
    // This method checks whether the input data is valid
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
    
    // This method retrieves the saved user from UserDefaults
    func retrieveUserFromUserDefaults() -> User? {
        let defaults = UserDefaults.standard
        
        if let savedUserData = defaults.data(forKey: "savedUser") {
            do {
                let decodedUser = try JSONDecoder().decode(User.self, from: savedUserData)
                return decodedUser
            } catch {
                print("Failed to decode user: \(error)")
            }
        }
        return nil
    }
    
    // This method checks if the user is authenticated
    func isAuthenticated(email: String?, password: String?) -> Bool {
        guard let user = self.retrieveUserFromUserDefaults() else {
            self.view.showMessage(title: "Login Failed", message: "No saved user found.")
            return false
        }
        
        if email != user.email {
            self.view.showMessage(title: "Login Failed", message: "Incorrect Email")
            return false
        } else if password != user.password {
            self.view.showMessage(title: "Login Failed", message: "Incorrect Password")
            return false
        } else {
            return true
        }
    }
}

// Extension to conform to the LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
    func tryLogin(email: String?, password: String?) {
        if self.isValidData(email: email, password: password) {
            if self.isAuthenticated(email: email, password: password) {
                //self.view.goToNextScreen(user: nil) 
                // Pass the authenticated user if needed
            }
        }
    }
}
