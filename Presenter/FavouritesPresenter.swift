//  FavouritesPresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 08/09/2024.
//

import Foundation
import UIKit
import CoreData

protocol FavouritesPresenterProtocol: AnyObject {
    
    func getFavourites()
    func getFavouritesArr() -> [FavouriteRecipient]
    func getFavouritesCount() -> Int
    var favArr: [FavouriteRecipient] { get }
    func deleteFavourite(at indexPath: IndexPath)
    func editFavourite(at indexPath: IndexPath, with updatedRecipient: FavouriteRecipient)
    func didTapDeleteButton(on indexPath: IndexPath)
    func didTapEditButton(on indexPath: IndexPath)
}

class FavouritesPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var favArr: [FavouriteRecipient] = []
    
    var view: FavouritesView?
    
    init(view: FavouritesView) {
        self.view = view
    }
    
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    func getFavourites() {
        do {
            self.favArr = try context.fetch(FavouriteRecipient.fetchRequest())
            DispatchQueue.main.async {
                self.view?.displayFavourites()
            }
        } catch {
        
                print("Error Fetching")
            }
    }
    
    func getFavouritesArr() -> [FavouriteRecipient] {
        return favArr
    }
    
    func getFavouritesCount() -> Int {
        return favArr.count
    }
    
  
    func deleteFavourite(at indexPath: IndexPath) {
        let itemToDelete = favArr[indexPath.row]
        context.delete(itemToDelete)
        do {
            try context.save()
            favArr.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.view?.displayFavourites()
            }
        } catch {
            DispatchQueue.main.async {
                self.view?.showError(message: "Failed to save context after deletion")
            }
        }
    }


    func editFavourite(at indexPath: IndexPath, with updatedRecipient: FavouriteRecipient) {
        let itemToEdit = favArr[indexPath.row]
        
        // Update the itemToEdit with the updatedRecipient data
        itemToEdit.userName = updatedRecipient.userName
        itemToEdit.accountNumber = updatedRecipient.accountNumber
        
        // Save the updated context
        do {
            try context.save()
            favArr[indexPath.row] = updatedRecipient
            DispatchQueue.main.async {
                self.view?.displayFavourites()
            }
        } catch {
            DispatchQueue.main.async {
                self.view?.showError(message: "Failed to save context after editing")
            }
        }
    }



       func didTapDeleteButton(on indexPath: IndexPath) {
           deleteFavourite(at: indexPath)
       }

    func didTapEditButton(on indexPath: IndexPath) {
        let itemToEdit = favArr[indexPath.row]
        print("didTapEditButton called for item: \(itemToEdit)")
        if let viewWithEdit = view as? FavouritesEditView {
            viewWithEdit.presentEditViewController(for: itemToEdit, at: indexPath)
        }
    }

    
}
