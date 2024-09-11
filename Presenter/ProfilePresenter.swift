//
//  ProfilePresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 11/09/2024.
//

import Foundation


protocol ProfilePresenterProtocol {
    func loadUserInfo()
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileVC?
    
    init(view: ProfileVC) {
        self.view = view
    }
    
    func loadUserInfo() {
            guard let user = UserManager.shared.currentUser else { return }
            
            let userInfo = [
                (title: "Name:", info: user.name ?? ""),
                (title: "Email:", info: user.email ?? ""),
                (title: "Birth Date:", info: user.birthDate ?? ""),
                (title: "Country:", info: user.country ?? ""),
                (title: "Bank Account:", info: "Account xxxx7890")
            ]
            
            view?.displayUserInfo(userInfo: userInfo)
        }
}

