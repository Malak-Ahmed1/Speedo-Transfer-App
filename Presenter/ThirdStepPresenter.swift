//
//  ThirdStepPresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 09/09/2024.
//

import Foundation
import UIKit
import CoreData

protocol ThirdStepProtocol: AnyObject {
    
    func addFavoriteRecipient(userName: String?, accountNumber: String?)
    
}

class ThirdStepPresenter {
    private weak var view: ThirdStepView?
    private let context: NSManagedObjectContext
    
    init(view: ThirdStepView, context: NSManagedObjectContext) {
        self.view = view
        self.context = context
    }
    
    
}




extension ThirdStepPresenter: ThirdStepProtocol {
    
    func addFavoriteRecipient(userName: String?, accountNumber: String?) {
        guard let userName = userName, !userName.isEmpty,
              let accountNumber = accountNumber, !accountNumber.isEmpty else {
            view?.displayError("User name or account number is missing.")
            return
        }
        
        let newFavRecipient = FavouriteRecipient(context: context)
        newFavRecipient.userName = userName
        newFavRecipient.accountNumber = accountNumber
        
        do {
            try context.save()
            view?.showSuccessMessage("Recipient added to favorites.")
        } catch {
            view?.displayError("Error saving recipient: \(error)")
        }
    }
}
