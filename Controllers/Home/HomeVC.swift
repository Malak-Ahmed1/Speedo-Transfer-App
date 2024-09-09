import UIKit

protocol HomeView: AnyObject {
    func displayTransactions(transactions: [Transaction])
}

class HomeVC: UIViewController, HomeView {
    
    @IBOutlet weak var recentTransactionsTableView: UITableView!
    
    private var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        
        presenter = HomePresenter(view: self)
        
        presenter.fetchRecentTransactions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchRecentTransactions()
        self.recentTransactionsTableView.reloadData()
    }
    
    func setUpTable() {
        
        recentTransactionsTableView.delegate = self
        recentTransactionsTableView.dataSource = self
        recentTransactionsTableView.register(UINib(nibName: "RecentTransactionCell", bundle: nil), forCellReuseIdentifier: "RecentTransactionCell")
        
    }
    func displayTransactions(transactions: [Transaction]) {
        // Reload the table view when transactions are fetched
        DispatchQueue.main.async {
            self.recentTransactionsTableView.reloadData()
        }
    }
    @IBAction func viewBtnClicked(_ sender: Any) {
        
        tabBarController?.selectedIndex = 2
    }
    @IBAction func notificationBtnClicked(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let notificationsVC = sb.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        notificationsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(notificationsVC, animated: true)
        navigationItem.title = ""
        notificationsVC.title = "Notifications"
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTransactionCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentTransactionsTableView.dequeueReusableCell(withIdentifier: "RecentTransactionCell", for: indexPath) as! RecentTransactionCell
        if let transaction = presenter.getTransaction(at: indexPath.row) {
            cell.setUpCell(reciepentName: transaction.recipientName!, visaInfo: transaction.visaInfo!, date: transaction.date!, amount: transaction.amount)
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedTransaction = presenter.getTransaction(at: indexPath.row) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let transactionInfoVC = storyboard.instantiateViewController(withIdentifier: "TransactionInfoVC") as! TransactionInfoVC
            transactionInfoVC.transaction = selectedTransaction
            navigationController?.pushViewController(transactionInfoVC, animated: true)
            navigationItem.backButtonTitle = "Back"
        }
    }
}
