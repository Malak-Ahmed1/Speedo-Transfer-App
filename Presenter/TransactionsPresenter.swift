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
        do {
            // Fetch all transactions
            self.transactionArr = try transactionService.fetchAllTransactions()
            DispatchQueue.main.async {
                self.view?.reloadTransactions()
            }
        } catch {
            print("Error Fetching Transactions")
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

