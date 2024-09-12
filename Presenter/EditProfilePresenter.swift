import Foundation

protocol EditProfileView: AnyObject {
    func updateUserInfo(fullName: String, email: String, country: String, birthDate: String)
    func showMessage(title: String, message: String)
}

class EditProfilePresenter {
    
    weak var view: EditProfileView?
    
    init(view: EditProfileView) {
        self.view = view
    }
    
    
    func saveChanges(fullName: String?, email: String?, country: String?, birthDate: String?) {
        guard let fullName = fullName, !fullName.isEmpty,
              let email = email, isValidEmail(email),
              let country = country, !country.isEmpty,
              let birthDate = birthDate, isValidAge(birthDate) else {
            view?.showMessage(title: "Sorry", message: "Please ensure all fields are valid and you are at least 16 years old.")
            return
        }
        
        UserManager.shared.currentUser?.name = fullName
        UserManager.shared.currentUser?.email = email
        UserManager.shared.currentUser?.country = country
        UserManager.shared.currentUser?.birthDate = birthDate
        UserManager.shared.saveUsersToUserDefaults()
        view?.showMessage(title: "Success", message: "Data Updated!")
    }
    
        

    
    // Email validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Age validation
    private func isValidAge(_ birthDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" // Ensure this matches your BirthDateTextField format
        if let date = dateFormatter.date(from: birthDate) {
            let calendar = Calendar.current
            let age = calendar.dateComponents([.year], from: date, to: Date()).year
            return (age ?? 0) >= 16
        }
        return false
    }
}
