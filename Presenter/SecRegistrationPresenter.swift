import Foundation

protocol SecondRegistrationPresenterProtocol {
    func tryRegister(country: String?, birthDate: String?)
}

class SecondRegistrationPresenter: SecondRegistrationPresenterProtocol {
    weak var view: SignUp2VC!
    
    private var user: User
    
    init(view: SignUp2VC, user: User) {
        self.view = view
        self.user = user
    }
    
    func isValidData(country: String?, birthDate: String?) -> Bool {
        guard let country = country?.trimmed, !country.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please enter your country!")
            return false
        }
        
        guard let birthDate = birthDate?.trimmed, !birthDate.isEmpty else {
            self.view.showMessage(title: "Sorry", message: "Please enter your birth date!")
            return false
        }
        
        if !isValidAge(birthDate: birthDate) {
            self.view.showMessage(title: "Sorry", message: "You must be at least 16 years old to register!")
            return false
        }
        
        return true
    }
    
    func isValidAge(birthDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        guard let birthDateFormatted = dateFormatter.date(from: birthDate) else {
            self.view.showMessage(title: "Error", message: "Invalid date format!")
            return false
        }
        
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDateFormatted, to: now)
        
        if let age = ageComponents.year, age >= 16 {
            return true
        } else {
            return false
        }
    }
    
    func updateUserData(country: String?, birthDate: String?) -> User {
        return User(name: user.name,
                    email: user.email,
                    password: user.password,
                    country: country,
                    birthDate: birthDate,
                    balance: 10000,
                    points: 0)
    }
    
    func tryRegister(country: String?, birthDate: String?) {
        if self.isValidData(country: country, birthDate: birthDate) {
            let updatedUser = self.updateUserData(country: country, birthDate: birthDate)
            UserManager.shared.addUser(updatedUser)
            self.view.goToNextScreen(user: updatedUser)
        }
    }
}
