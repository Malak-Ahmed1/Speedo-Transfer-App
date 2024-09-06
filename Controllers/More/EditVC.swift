//
//  EditVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 06/09/2024.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var recipientNameTextField: CustomTextField!
    @IBOutlet weak var recipientAccountTextField: CustomTextField!
    
    // Recipient to be edited
    var recipient: FavouriteRecipient?

    // Closure to notify FavouritesVC about the update
    var onSave: ((FavouriteRecipient) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Pre-fill the text fields with the recipient data
        if let recipient = recipient {
            recipientNameTextField.text = recipient.userName
            recipientAccountTextField.text = recipient.accountNumber
        }
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        guard let recipient = recipient else { return }
        
        
        
        // To.Do: check first if user exits on API
        
        
        // Update the recipient object
        recipient.userName = recipientNameTextField.text
        recipient.accountNumber = recipientAccountTextField.text
        
        // Save changes to Core Data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Failed to save edited recipient: \(error)")
            return
        }

        // Notify FavouritesVC about the update
        onSave?(recipient)

        // Dismiss the view controller
        dismiss(animated: true)
    }
}

