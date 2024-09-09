//
//  EditFavouritePresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 08/09/2024.
//

import Foundation
import UIKit

protocol EditFavouriteProtocol: AnyObject {
    func saveRecipient(name: String?, account: String?)
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
}

extension EditFavouritePresenter: EditFavouriteProtocol {

    func viewDidLoad() {
        if let recipient = recipient {
            view?.displayRecipientDetails(name: recipient.userName ?? "", account: recipient.accountNumber ?? "")
        }
    }

    func saveRecipient(name: String?, account: String?) {
        guard let recipient = recipient else { return }
        
        recipient.userName = name
        recipient.accountNumber = account
        
        do {
            try context.save()
            // Notify the view controller to refresh data
            view?.showError(message: "Recipient updated successfully")
        } catch {
            view?.showError(message: "Failed to save edited recipient: \(error)")
        }
    }
}
