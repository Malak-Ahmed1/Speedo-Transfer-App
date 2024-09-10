//
//  SecRegistrationPresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 10/09/2024.
//

import Foundation

protocol SecondRegistrationPresenterProtocol {
    func tryRegister(country: String? , birthDate: String?)
}

class SecondRegistrationPresenter  {
    weak var view: SignUp2VC!
    
    private var user: User
    
    init(view: SignUp2VC, user: User) {
        self.view = view
        self.user = user
       // print("User received in CountryBirthDatePresenter: \(user)")
    }
    
    func isValidData(country: String?, birthDate: String?) -> Bool {
        guard country?.trimmed != "" else {
            self.view.showMessage(title: "Sorry", message: "Please enter your country!")
            return false
        }
        
        guard birthDate?.trimmed != "" else {
            self.view.showMessage(title: "Sorry", message: "Please enter your birth date!")
            return false
        }
        
        return true
    }
    
    func updateUserData(country: String?, birthDate: String?) -> User {
        let updatedUser = User(name: self.user.name,
                               email: self.user.email,
                               password: self.user.password,
                               country: country,
                               birthDate: birthDate)
        return updatedUser
    }
}

extension SecondRegistrationPresenter: SecondRegistrationPresenterProtocol {
    func tryRegister(country: String?, birthDate: String?) {
        if self.isValidData(country: country, birthDate: birthDate) {
            _ = self.updateUserData(country: country, birthDate: birthDate)
            //self.view.completeRegistration(user: updatedUser)
        }
    }
}
