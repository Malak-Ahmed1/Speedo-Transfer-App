//
//  RegistrationPresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 10/09/2024.
//

import Foundation

protocol RegistrationPresenterProtocol {
    func tryRegister(name: String?, email: String?, pass1: String?, pass2: String?)
}

class RegistrationPresenter: RegistrationPresenterProtocol  {
   weak var view: SignUpVC!
  // weak var view: ViewVCProtocol!
    
    init(view: SignUpVC) {
        self.view = view
    }
    
    func isValidData(name: String?, email: String?, pass1: String?, pass2: String?) -> Bool {
        guard name?.trimmed != "" else {
            self.view.showMessage(title: "Sorry", message: "Please enter your name!")
            return false
        }
        
        guard email?.trimmed != "" else {
            self.view.showMessage(title: "Sorry", message: "Please enter your email!")
            return false
        }
        
        guard pass1?.trimmed != "" else {
            self.view.showMessage(title: "Sorry", message: "Please enter your password!")
            return false
        }
        
        guard pass2?.trimmed != "" else {
            self.view.showMessage(title: "Sorry", message: "Please confirm your password!")
            return false
        }
        
        return true
    }
    
    func isConfirmedPassowrd(password: String, confirmedPassword: String) -> Bool {
        if password == confirmedPassword {
            return true
        }
        self.view.showMessage(title: "Sorry", message: "Please note that the password isn't confirmed successfully!")
        return false
    }
    
    func getUserData(name: String?, email: String?, pass: String?) -> User {
        let user = User(name: name!, email: email!, password: pass!, country: nil , birthDate: nil)
        return user
    }
    
}

extension RegistrationPresenter {
    func tryRegister(name: String?, email: String?, pass1: String?, pass2: String?){
        if self.isValidData(name: name, email: email, pass1: pass1, pass2: pass2){
            if self.isConfirmedPassowrd(password: pass1!, confirmedPassword: pass2!) {
                _ = self.getUserData(name: name, email: email, pass: pass1)
//                self.view.goToNextScreen(user: user)
            }
        }
    }
}
