//
//  EditProfilePresenter.swift
//  Speedo Transfer App
//
//  Created by mariam labib on 11/09/2024.
//

import Foundation

protocol EditProfileView: AnyObject {
    func updateUserInfo(fullName: String, email: String, country: String, birthDate: String)
    func showSuccessMessage(_ message: String)
    func showErrorMessage(_ message: String)
}

class EditProfilePresenter {
    
    weak var view: EditProfileView?
    
    init(view: EditProfileView) {
        self.view = view
    }
    
    func viewDidLoad() {
        // Load user data from UserDefaults
        if let user = retrieveUserFromUserDefaults() {
            view?.updateUserInfo(fullName: user.name ?? "", email: user.email ?? "", country: user.country ?? "", birthDate: user.birthDate ?? "")
        }
    }
    
    func saveChanges(fullName: String?, email: String?, country: String?, birthDate: String?) {
        guard let fullName = fullName, !fullName.isEmpty,
              let email = email, !email.isEmpty,
              let country = country, !country.isEmpty,
              let birthDate = birthDate, !birthDate.isEmpty else {
            view?.showErrorMessage("All fields must be filled.")
            return
        }
        
        // Save to UserDefaults (or another persistent storage)
        if var user = retrieveUserFromUserDefaults() {
            user.name = fullName
            user.email = email
            user.country = country
            user.birthDate = birthDate
            saveUserToUserDefaults(user)
            
            view?.showSuccessMessage("Profile updated successfully.")
        } else {
            view?.showErrorMessage("Failed to retrieve user information.")
        }
    }
    
    private func retrieveUserFromUserDefaults() -> User? {
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
    
    private func saveUserToUserDefaults(_ user: User) {
        let defaults = UserDefaults.standard
        do {
            let encodedData = try JSONEncoder().encode(user)
            defaults.set(encodedData, forKey: "savedUser")
        } catch {
            print("Failed to encode user: \(error)")
        }
    }
}
