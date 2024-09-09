import UIKit

protocol FirstStepViewProtocol: AnyObject {
    func showFavourites()
}


class FirstStepVC: UIViewController, FirstStepViewProtocol {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var recipientAccountTextField: CustomTextField!
    @IBOutlet weak var recipientNameTextField: CustomTextField!
    weak var delegate: StepNavigationDelegate?

    private var presenter: FirstStepPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FirstStepPresenter(view: self, stepNavigationDelegate: delegate)
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        presenter?.backButtonTapped()
    }

    @IBAction func favouriteBtnClicked(_ sender: Any) {
        presenter?.favouriteButtonTapped()
    }
    
    @IBAction func continueBtnClicked(_ sender: UIButton) {
        presenter?.continueButtonTapped()
    }

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
}

