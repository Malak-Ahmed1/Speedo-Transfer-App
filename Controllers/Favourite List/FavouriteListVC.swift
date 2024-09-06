//
//  FavouriteListVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 03/09/2024.
//

import UIKit



class FavouriteListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var favArr: [FavouriteRecipient] = []
    

    @IBOutlet weak var favouriteListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteListTable.delegate = self
        favouriteListTable.dataSource = self
       
       
       

        // Registering the custom cell if not using storyboard prototype cell
        favouriteListTable.register(UINib(nibName: "FavouriteListCell", bundle: nil), forCellReuseIdentifier: "FavouriteListCell")
        
      
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
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteListTable.dequeueReusableCell(withIdentifier: "FavouriteListCell", for: indexPath) as! FavouriteListCell
        
        
        let data = favArr[indexPath.row]
        cell.setUpCell(userName: data.userName!, accountNumber: data.accountNumber!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    private func tableView(_ tableView: UITableView, willDisplay cell: FavouriteListCell, forRowAt indexPath: IndexPath) {
        
        var frame = cell.contentView.frame
        frame.size.width = 400
        cell.contentView.frame = frame
    }
}


