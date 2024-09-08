//
//  HomePresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 08/09/2024.
//

import Foundation
import UIKit
import CoreData

protocol HomePresenterProtocol: AnyObject {
    
    var recentTransactionArr: [Transaction] { get }
    func getRecentTransactions()
    func getTransactionCount() -> Int
    func getTransactionArr() -> [Transaction]
}

class HomePresenter {
    
    weak var view: HomeView?
    var recentTransactionArr: [Transaction] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(view: HomeView) {
        self.view = view
    }
    
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func getRecentTransactions() {
        do {
            self.recentTransactionArr = try context.fetch(Transaction.fetchRequest())
            DispatchQueue.main.async {
                self.view?.displayTransaction(transactions: self.recentTransactionArr)
            }
        } catch {
            print("Error Fetching")
        }
    }
    
    func getTransactionCount() -> Int {
        return self.recentTransactionArr.count
    }
    
    func getTransactionArr() -> [Transaction] {
        return recentTransactionArr
    }
}
