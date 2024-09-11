//
//  ProfilePresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 11/09/2024.
//

import Foundation

protocol ProfileView: AnyObject {
    func displayUserName(_ name: String)
    func updateTableView()
}

class ProfilePresenter {
    
    weak var view: ProfileView?
    
    init(view: ProfileView) {
        self.view = view
    }
    
    func viewDidLoad() {
        print("Profile opened")
        
        let def = UserDefaults.standard
        def.setValue(true, forKey: "isLoggedIn")
        
        if let user = retrieveUserFromUserDefaults() {
            view?.displayUserName(user.name!)
        } else {
            view?.displayUserName("Unknown User")
        }
        
        view?.updateTableView()
    }
    
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
}
