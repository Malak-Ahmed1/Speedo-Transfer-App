import UIKit

class SignUp2VC: UIViewController, CountrySelectionDelegate {

    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var BirthDateTextField: UITextField!

    private var datePicker: UIDatePicker?
    var viewModel: SecondRegistrationPresenterProtocol!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            viewModel = SecondRegistrationPresenter(view: self, user: user)
        } else {
            print("Error: User is nil")
        }
        setupDatePicker()
    }

    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        if let datePicker = datePicker {
            BirthDateTextField.inputView = datePicker
        }
    }

    @objc private func dateChanged() {
        if let datePicker = datePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            BirthDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
    }

    @IBAction func datePickerClicked(_ sender: Any) {
        BirthDateTextField.becomeFirstResponder()
    }

    @IBAction func countryBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let countryVC = storyboard.instantiateViewController(withIdentifier: "CountrySelectionVC") as? CountrySelectionVC {
            countryVC.modalPresentationStyle = .pageSheet
            if let sheet = countryVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 50
            }
            countryVC.delegate = self // Set the delegate here
            present(countryVC, animated: true)
        } else {
            print("Failed to instantiate CountrySelectionVC")
        }
    }

    @IBAction func ContinueBtn(_ sender: UIButton) {
        self.viewModel?.tryRegister(country: CountryTextField.text, birthDate: BirthDateTextField.text)
    }

    @IBAction func SignInBtn(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        signInVC.modalPresentationStyle = .fullScreen 
        present(signInVC, animated: true)
    }

    // MARK: - CountrySelectionDelegate

    func didSelectCountry(_ country: String) {
        CountryTextField.text = country
    }
}

extension SignUp2VC {
    func showMessage(title: String, message: String) {
                self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
    
    func goToNextScreen(user: User?) {
        let sb = UIStoryboard(name: "Main2", bundle: nil)
        let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        signInVC.user = user
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true)
    }
}
