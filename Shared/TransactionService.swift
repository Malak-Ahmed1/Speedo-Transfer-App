//
//  TransactionService.swift
//  Speedo Transfer App
//
//  Created by 1234 on 09/09/2024.
//

import Foundation
import CoreData
import UIKit

class TransactionService {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Fetch all transactions from Core Data
    func fetchAllTransactions() throws -> [Transaction] {
        return try context.fetch(Transaction.fetchRequest())
    }
    
    // Fetch a limited number of recent transactions
    func fetchRecentTransactions(limit: Int) throws -> [Transaction] {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.fetchLimit = limit
        return try context.fetch(request)
    }
}

