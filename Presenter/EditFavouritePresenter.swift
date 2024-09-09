//
//  EditFavouritePresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 08/09/2024.
//

import Foundation
import UIKit

protocol EditFavouriteProtocol: AnyObject {
    func saveRecipient(recipientName: String?, recipientAccount: String?)
    func viewDidLoad()
}

class EditFavouritePresenter {
    
    private weak var view: EditView?
    private var recipient: FavouriteRecipient?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(view: EditView, recipient: FavouriteRecipient?) {
        self.view = view
        self.recipient = recipient
    }
    func isValidData(recipientName: String?, recipientAccount: String?) -> Bool {
        
        guard recipientName?.trimmed != "" else {
            self.view?.showMessage(title: "Sorry", message: "Please enter recipient name!")
            return false
        }
        
        guard recipientAccount?.trimmed != "" else {
            self.view?.showMessage(title: "Sorry", message: "Please enter recipient Account!")
            return false
        }
        
        return true
    }
}

extension EditFavouritePresenter: EditFavouriteProtocol {
    
    func viewDidLoad() {
        if let recipient = recipient {
            view?.displayRecipientDetails(name: recipient.userName ?? "", account: recipient.accountNumber ?? "")
        }
    }
    
    func saveRecipient(recipientName: String?, recipientAccount: String?) {
        guard let recipient = recipient else { return }
        if isValidData(recipientName: recipientName, recipientAccount: recipientAccount)
        {
            recipient.userName = recipientName
            recipient.accountNumber = recipientAccount
        } else {
            
            return
        }
        do {
            try context.save()
            // Notify the view controller to refresh data
            print("Recipient updated successfully")
        } catch {
            print("Failed to save edited recipient: \(error)")
        }
    }
}
