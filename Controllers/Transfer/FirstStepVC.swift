import UIKit

class FirstStepVC: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var recipientAccountTextFiled: CustomTextField!
    
    @IBOutlet weak var recipientNameTextFiled: CustomTextField!
    weak var delegate: StepNavigationDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

  
    @IBAction func backBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }
    
    @IBAction func favouriteBtnClicked(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let favouriteListVC = sb.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
        favouriteListVC.modalPresentationStyle = .pageSheet
        favouriteListVC.fetchList()
        if let sheet = favouriteListVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 50
            
        }

        present(favouriteListVC, animated: true)
        
    }
    
    @IBAction func continueBtnClicked(_ sender: UIButton) {
        delegate?.goToNextStep(currentStep: self)
    }
}
