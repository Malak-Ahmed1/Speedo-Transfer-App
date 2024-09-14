import UIKit

protocol FirstStepViewProtocol: AnyObject {
    func showFavourites()
    func showMessage(title: String, message: String)
    
}


class FirstStepVC: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var recipientAccountTextField: CustomTextField!
    @IBOutlet weak var recipientNameTextField: CustomTextField!
    weak var delegate: StepNavigationDelegate?
    
    private var presenter: FirstStepPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FirstStepPresenter(view: self, stepNavigationDelegate: delegate)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountTextField.text = ""
        recipientAccountTextField.text = ""
        recipientNameTextField.text = ""
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        presenter?.backButtonTapped()
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func favouriteBtnClicked(_ sender: Any) {
        presenter?.favouriteButtonTapped()
    }
    
    @IBAction func continueBtnClicked(_ sender: UIButton) {
        presenter?.continueButtonTapped(amount: amountTextField.text, recipientName: recipientNameTextField.text, recipientAccount: recipientAccountTextField.text)
    }
    
    
}

extension FirstStepVC: FirstStepViewProtocol {
    func showFavourites() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let favouriteListVC = sb.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
        favouriteListVC.modalPresentationStyle = .pageSheet
        if let sheet = favouriteListVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 50
        }
        present(favouriteListVC, animated: true)
    }
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: {
            self.dismiss(animated: true)
        }, cancelHandler: nil)
    }
    
}

