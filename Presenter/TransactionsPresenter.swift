//
//  TransactionsPresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 09/09/2024.
//

import Foundation

protocol TransactionsPresenterProtocol: AnyObject {
    func fetchAllTransactions()
    func getTransaction(at index: Int) -> Transaction?
    func getTransactionCount() -> Int
}

class TransactionsPresenter {
    
    private weak var view: TransactionsView?
    private var transactionArr: [Transaction] = []
    private let transactionService = TransactionService()
    
    init(view: TransactionsView) {
        self.view = view
    }
    
    
}

extension TransactionsPresenter: TransactionsPresenterProtocol {
    
    func fetchAllTransactions() {
        guard let currentUserEmail = UserManager.shared.currentUser?.email else {
            print("No current user found")
            return
        }

        do {
            // Fetch all transactions for the current user
            self.transactionArr = try transactionService.fetchAllTransactions(forUser: currentUserEmail)
            
            print("Fetched transactions: \(self.transactionArr)") // Debug print

            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadTransactions()
            }
        } catch {
            print("Error fetching transactions for user: \(currentUserEmail)")
        }
    }

    
    func getTransaction(at index: Int) -> Transaction? {
        guard index >= 0 && index < transactionArr.count else { return nil }
        return transactionArr[index]
    }
    
    func getTransactionCount() -> Int {
        return transactionArr.count
    }
}

