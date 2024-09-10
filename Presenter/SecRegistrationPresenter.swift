import Foundation

protocol SecondRegistrationPresenterProtocol {
    func tryRegister(country: String?, birthDate: String?)
}

class SecondRegistrationPresenter {
    weak var view: SignUp2VC!
    
    private var user: User
    
    init(view: SignUp2VC, user: User) {
        self.view = view
        self.user = user
    }
    
    func isValidData(country: String?, birthDate: String?) -> Bool {
        guard let country = country?.trimmed, !country.isEmpty else {
            print("Country is empty")  // Debugging statement
            self.view.showMessage(title: "Sorry", message: "Please enter your country!")
            return false
        }
        
        guard let birthDate = birthDate?.trimmed, !birthDate.isEmpty else {
            print("BirthDate is empty")  // Debugging statement
            self.view.showMessage(title: "Sorry", message: "Please enter your birth date!")
            return false
        }
        
        return true
    }
    
    func updateUserData(country: String?, birthDate: String?) -> User {
        return User(name: user.name,
                    email: user.email,
                    password: user.password,
                    country: country,
                    birthDate: birthDate)
    }
}

extension SecondRegistrationPresenter: SecondRegistrationPresenterProtocol {
    func tryRegister(country: String?, birthDate: String?) {
        if self.isValidData(country: country, birthDate: birthDate) {
            let updatedUser = self.updateUserData(country: country, birthDate: birthDate)
            UserManager.shared.addUser(updatedUser)
            self.view.goToNextScreen(user: updatedUser)
        }
    }
}
