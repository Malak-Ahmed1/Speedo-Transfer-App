//
//  ThirdStepVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

protocol ThirdStepView: AnyObject {
    func displayError(_ message: String)
    func showSuccessMessage(_ message: String)
}


class ThirdStepVC: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userAccountLabel: UILabel!
    @IBOutlet weak var recipientNameLabel: UILabel!
    @IBOutlet weak var recipientAccountLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    weak var delegate: StepNavigationDelegate?
    private var presenter: ThirdStepProtocol!
    
    private var amount: String?
    private var recipientName: String?
    private var recipientAccount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        presenter = ThirdStepPresenter(view: self, context: context)
        updateUI()
        
        
    }
    
    private func updateUI() {
        amountLabel?.text = amount
        recipientNameLabel?.text = recipientName
        recipientAccountLabel?.text = recipientAccount
        if userNameLabel == nil {
            print("userNameLabel is nil")
        } else {
            // Check if `currentUser` is nil
            if let currentUser = UserManager.shared.currentUser {
                if let name = currentUser.name {
                    userNameLabel.text = name
                }
            }
        }
        if userNameLabel == nil {
            print("userNameLabel is nil")
        } else {
            userAccountLabel.text = "Account xxxx7890"
        }
    }
    
    func setupTransactionInfo(amount: String?, recipientName: String?, recipientAccount: String?) {
        self.amount = amount
        self.recipientName = recipientName
        self.recipientAccount = recipientAccount
        updateUI()
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
        tabBarController?.selectedIndex = 0
        
    }
    
    @IBAction func toHomeBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func addFavouriteBtnClicked(_ sender: Any) {
        self.showAlert(title: "Sure?", message: "Are you sure you want to add this user to favorites?", okHandler: {
            self.presenter.addFavoriteRecipient(userName: self.recipientNameLabel.text, accountNumber: self.recipientAccountLabel.text)
        }, cancelHandler: {
        })
    }
    
    
    
}

extension ThirdStepVC: ThirdStepView {
    
    // MARK: - ThirdStepView Protocol Methods
    
    func displayError(_ message: String) {
        // Handle error display, e.g., show an alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSuccessMessage(_ message: String) {
        // Handle success, e.g., show a confirmation alert or navigate
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
