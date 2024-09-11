import Foundation
import CoreData
import UIKit

class TransactionService {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Fetch all transactions for a specific user by email
    func fetchAllTransactions(forUser email: String) throws -> [Transaction] {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email) // Fetch only transactions for the specific user
        
        do {
            return try context.fetch(request)
        } catch {
            throw error // Propagate the error for handling in the caller
        }
    }

    // Fetch recent transactions for a specific user with a limit
    func fetchRecentTransactions(forUser email: String, limit: Int) throws -> [Transaction] {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email) // Fetch only transactions for the specific user
        request.fetchLimit = limit
        
        do {
            return try context.fetch(request)
        } catch {
            throw error // Propagate the error for handling in the caller
        }
    }
}
