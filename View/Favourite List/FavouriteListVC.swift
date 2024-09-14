//
//  FavouriteListVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 03/09/2024.
//

import UIKit

protocol FavouritesView: AnyObject {
    func displayFavourites()
    func showError(message: String)
}

class FavouriteListVC: UIViewController, FavouritesView {
    var presenter: FavouritesPresenterProtocol!
    
    @IBOutlet weak var favouriteListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        presenter = FavouritesPresenter(view: self, userEmail: (UserManager.shared.currentUser?.email)!)
        presenter.getFavourites()
    }
    
    
    func setUpTable() {
        
        favouriteListTable.delegate = self
        favouriteListTable.dataSource = self
        favouriteListTable.register(UINib(nibName: "FavouriteListCell", bundle: nil), forCellReuseIdentifier: "FavouriteListCell")
    }
    
    func displayFavourites() {
        DispatchQueue.main.async {
            self.favouriteListTable.reloadData()
        }
    }
    func showError(message: String) {
           print(message)
       }
}


extension FavouriteListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getFavouritesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteListTable.dequeueReusableCell(withIdentifier: "FavouriteListCell", for: indexPath) as! FavouriteListCell
        
        
        let data = self.presenter.getFavouritesArr()[indexPath.row]
        cell.setUpCell(userName: data.userName!, accountNumber: data.accountNumber!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
