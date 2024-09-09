//
//  EditVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 06/09/2024.
//

import UIKit

protocol EditView: AnyObject {
    func displayRecipientDetails(name: String, account: String)
    func showMessage(title: String, message: String)
}

class EditVC: UIViewController {

    @IBOutlet weak var recipientNameTextField: CustomTextField!
    @IBOutlet weak var recipientAccountTextField: CustomTextField!
    
    var recipient: FavouriteRecipient?
    var presenter: EditFavouriteProtocol!
    var onSave: ((FavouriteRecipient) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EditFavouritePresenter(view: self, recipient: recipient)
        presenter.viewDidLoad()
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        presenter.saveRecipient(recipientName: recipientNameTextField.text, recipientAccount: recipientAccountTextField.text)
        
        if let updatedRecipient = recipient {
            onSave?(updatedRecipient)
        }
        
        self.showAlert(title: "Success", message: "Recipient details saved successfully.", okHandler: {
            self.dismiss(animated: true)
        }, cancelHandler: nil)
    }


}

extension EditVC: EditView {
    func displayRecipientDetails(name: String, account: String) {
        recipientNameTextField.text = name
        recipientAccountTextField.text = account
    }
    
    func showMessage(title: String, message: String) {
        self.showAlert(title: title, message: message, okHandler: nil, cancelHandler: nil)
    }
    
}
