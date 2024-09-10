//
//  UserManager.swift
//  Speedo Transfer App
//
//  Created by 1234 on 11/09/2024.
//

import Foundation
class UserManager {
    static let shared = UserManager()
    private(set) var users: [User] = []
    var currentUser: User?
    private init() {}
    
    func addUser(_ user: User) {
        users.append(user)
        saveUsersToUserDefaults()
    }
    
    func saveUsersToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(users)
            UserDefaults.standard.set(encodedData, forKey: "savedUsers")
        } catch {
            print("Failed to encode users: \(error)")
        }
    }
    
    func loadUsersFromUserDefaults() {
        guard let savedUsersData = UserDefaults.standard.data(forKey: "savedUsers") else { return }
        do {
            users = try JSONDecoder().decode([User].self, from: savedUsersData)
        } catch {
            print("Failed to decode users: \(error)")
        }
    }
}
