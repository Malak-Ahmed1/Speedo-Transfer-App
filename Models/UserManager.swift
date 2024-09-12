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
    
    func registerUser(name: String, email: String, password: String, country: String, birthDate: String) -> Bool {
        var users = UserDefaults.standard.array(forKey: "users") as? [[String: Any]] ?? []

        if users.contains(where: { ($0["email"] as? String)?.lowercased() == email.lowercased() }) {
            print("Email already exists")
            return false
        }

        let newUser: [String: Any] = [
            "name": name,
            "email": email.lowercased(),
            "password": password,
            "country": country,
            "birthDate": birthDate,
            "balance": 10000.0,
            "points": 0
        ]

        users.append(newUser)
        UserDefaults.standard.set(users, forKey: "users")
        print("User registered successfully")
        return true
    }

    func loginUser(email: String, password: String) -> Bool {
        let users = UserDefaults.standard.array(forKey: "users") as? [[String: Any]] ?? []

        for user in users {
            if let savedEmail = user["email"] as? String,
               let savedPassword = user["password"] as? String,
               savedEmail.lowercased() == email.lowercased(),
               savedPassword == password {

                UserManager.shared.currentUser = User(name: user["name"] as? String,
                                                      email: savedEmail,
                                                      password: savedPassword,
                                                      country: user["country"] as? String,
                                                      birthDate: user["birthDate"] as? String,
                                                      balance: user["balance"] as? Double ?? 10000,
                                                      points: user["points"] as? Int ?? 0)
                return true
            }
        }
        
        print("Invalid email or password")
        return false
    }

    func updatePoints(for email: String, newPoints: Int) {
        var users = UserDefaults.standard.array(forKey: "users") as? [[String: Any]] ?? []
        
        if let index = users.firstIndex(where: { ($0["email"] as? String)?.lowercased() == email.lowercased() }) {
            users[index]["points"] = newPoints
            UserDefaults.standard.set(users, forKey: "users")
        }
    }

     func saveUsersToUserDefaults() {
        let usersDicts = users.map { user -> [String: Any] in
            return [
                "name": user.name ?? "",
                "email": user.email ?? "",
                "password": user.password ?? "",
                "country": user.country ?? "",
                "birthDate": user.birthDate ?? "",
                "balance": user.balance ?? 10000,
                "points": user.points ?? 0
            ]
        }
        UserDefaults.standard.set(usersDicts, forKey: "users")
    }
}
