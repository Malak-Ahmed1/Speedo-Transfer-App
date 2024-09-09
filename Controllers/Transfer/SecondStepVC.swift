//
//  SecondStepVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

protocol SecondStepView: AnyObject {
    func displayError(_ message: String)
    func showSuccessMessage(_ message: String)
}


class SecondStepVC: UIViewController {
    
    
    @IBOutlet weak var firstAmountLabel: UILabel!
    @IBOutlet weak var secondAmountLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userAccountLabel: UILabel!
    @IBOutlet weak var recipientNameLabel: UILabel!
    
    @IBOutlet weak var recipientAccountLabel: UILabel!
    weak var delegate: StepNavigationDelegate?
    private var presenter: SecondStepProtocol!
    
    private var amount: String?
    private var recipientName: String?
    private var recipientAccount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        presenter = SecondStepPresenter(view: self, context: context)
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func updateUI() {
        if let amount = amount {
            firstAmountLabel?.text = amount
            secondAmountLabel?.text = amount
        }
        recipientNameLabel?.text = recipientName
        recipientAccountLabel?.text = recipientAccount
    }
    
    func setupTransactionInfo(amount: String?, recipientName: String?, recipientAccount: String?) {
        self.amount = amount
        self.recipientName = recipientName
        self.recipientAccount = recipientAccount
        updateUI()
    }
    
    @IBAction func confirmBtnClicked(_ sender: Any) {
        presenter.confirmTransaction(recipientName: recipientNameLabel.text, firstAmount: firstAmountLabel.text)
    }
    
    @IBAction func previousBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }
    @IBAction func backBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
        
    }
    
}
extension SecondStepVC: SecondStepView {
    
    // MARK: - SecondStepView Protocol Methods
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSuccessMessage(_ message: String) {
        delegate?.goToNextStep(currentStep: self)
    }
}


