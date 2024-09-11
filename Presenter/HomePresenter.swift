import Foundation

protocol HomePresenterProtocol: AnyObject {
    func fetchRecentTransactions()
    func getTransaction(at index: Int) -> Transaction?
    func getTransactionCount() -> Int
}

class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeView?
    private var recentTransactionArr: [Transaction] = []
    private let transactionService = TransactionService()
    
    init(view: HomeView) {
        self.view = view
    }
    
    func fetchRecentTransactions() {
        guard let currentUserEmail = UserManager.shared.currentUser?.email else {
            print("No current user found")
            return
        }

        do {
            // Fetch recent transactions
            self.recentTransactionArr = try transactionService.fetchRecentTransactions(forUser: currentUserEmail, limit: 5)
            
            print("Fetched recent transactions: \(self.recentTransactionArr)") // Debug print

            DispatchQueue.main.async { [weak self] in
                self?.view?.displayTransactions(transactions: self!.recentTransactionArr)
            }
        } catch {
            print("Error fetching recent transactions for user: \(currentUserEmail)")
        }
    }

    
    func getTransaction(at index: Int) -> Transaction? {
        guard index >= 0 && index < recentTransactionArr.count else { return nil }
        return recentTransactionArr[index]
    }
    
    func getTransactionCount() -> Int {
        return recentTransactionArr.count
    }
}
