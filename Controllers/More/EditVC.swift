//
//  EditVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 06/09/2024.
//

import UIKit

protocol EditView: AnyObject {
    func displayRecipientDetails(name: String, account: String)
    func showError(message: String)
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
        guard let name = recipientNameTextField.text, !name.isEmpty,
              let account = recipientAccountTextField.text, !account.isEmpty else {
            showError(message: "Please fill in all fields.")
            return
        }
        
        presenter.saveRecipient(name: name, account: account)
        
        // Ensure the updated recipient is passed to onSave
        if let updatedRecipient = recipient {
            onSave?(updatedRecipient)
            
        }
        
        dismiss(animated: true)
    }

}

extension EditVC: EditView {
    func displayRecipientDetails(name: String, account: String) {
        recipientNameTextField.text = name
        recipientAccountTextField.text = account
    }
    
    func showError(message: String) {
      print(message)
    }
}
