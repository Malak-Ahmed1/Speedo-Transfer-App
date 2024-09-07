//
//  FavouritesVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 06/09/2024.
//

import UIKit

class FavouritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var favArr: [FavouriteRecipient] = []
    

    @IBOutlet weak var favouriteListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteListTable.delegate = self
        favouriteListTable.dataSource = self
        
        favouriteListTable.register(UINib(nibName: "FavouritesCell", bundle: nil), forCellReuseIdentifier: "FavouritesCell")
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchList() // Reload the transactions list whenever the view appears
        }
    
     func fetchList() {
        
        do {
            self.favArr = try context.fetch(FavouriteRecipient.fetchRequest())
            DispatchQueue.main.async {
                self.favouriteListTable.reloadData()
            }
        } catch {
        
                print("Error Fetching")
            }
        }
    
    func deleteItem(_ item: FavouriteRecipient, at indexPath: IndexPath) {
        context.delete(item) // Delete the object from Core Data
        do {
            try context.save() // Save changes to Core Data
            favArr.remove(at: indexPath.row) // Update the data source array
            favouriteListTable.deleteRows(at: [indexPath], with: .automatic) // Remove the row from the table view
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteListTable.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! FavouritesCell
        
        let data = favArr[indexPath.row]
        cell.setUpCell(userName: data.userName!, accountNumber: data.accountNumber!)
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
   

}

extension FavouritesVC: FavouritesCellDelegate {
    func didTapDeleteButton(on cell: FavouritesCell) {
        // Find the index path of the cell
        if let indexPath = favouriteListTable.indexPath(for: cell) {
            let itemToDelete = favArr[indexPath.row]
            deleteItem(itemToDelete, at: indexPath)
        }
    }
    
    func didTapEditButton(on cell: FavouritesCell) {
        if let indexPath = favouriteListTable.indexPath(for: cell) {
            let itemToEdit = favArr[indexPath.row]
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let editVC = sb.instantiateViewController(withIdentifier: "EditVC") as! EditVC
            editVC.modalPresentationStyle = .pageSheet
            
            // Pass the recipient data to EditVC
            editVC.recipient = itemToEdit
            
            // Handle updates through closure or delegate
            editVC.onSave = { [weak self] updatedRecipient in
                self?.favArr[indexPath.row] = updatedRecipient
                self?.favouriteListTable.reloadRows(at: [indexPath], with: .automatic)
            }

            if let sheet = editVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 50
            }

            present(editVC, animated: true)
        }
    }


    
}

