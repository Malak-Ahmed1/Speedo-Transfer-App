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
        do {
            // Fetch a limited number of recent transactions (e.g., 5)
            self.recentTransactionArr = try transactionService.fetchRecentTransactions(limit: 5)
            DispatchQueue.main.async {
                self.view?.displayTransactions(transactions: self.recentTransactionArr)
            }
        } catch {
            print("Error Fetching Recent Transactions")
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
