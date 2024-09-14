import UIKit

class EditProfileVC: UIViewController, EditProfileView, CountrySelectionDelegate {

    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var BirthDateTextField: UITextField!
    private var datePicker: UIDatePicker?

    var presenter: EditProfilePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EditProfilePresenter(view: self)
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

    @IBAction func countriesBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let countryVC = storyboard.instantiateViewController(withIdentifier: "CountrySelectionVC") as? CountrySelectionVC {
            countryVC.modalPresentationStyle = .pageSheet
            if let sheet = countryVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 50
            }
            countryVC.delegate = self
            present(countryVC, animated: true)
        } else {
            print("Failed to instantiate CountrySelectionVC")
        }
    }

    @IBAction func dateBtnClicked(_ sender: Any) {
        BirthDateTextField.becomeFirstResponder()
    }

    @IBAction func SaveBtn(_ sender: UIButton) {
        presenter?.saveChanges(
            fullName: FullNameTextField.text,
            email: EmailTextField.text,
            country: CountryTextField.text,
            birthDate: BirthDateTextField.text
        )
    }

    func updateUserInfo(fullName: String, email: String, country: String, birthDate: String) {
        FullNameTextField.text = fullName
        EmailTextField.text = email
        CountryTextField.text = country
        BirthDateTextField.text = birthDate
    }

    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }

    // MARK: - CountrySelectionDelegate
    func didSelectCountry(_ country: String) {
        CountryTextField.text = country
    }
}
