import UIKit

protocol HomeView: AnyObject {
    func displayTransactions(transactions: [Transaction])
}

class HomeVC: UIViewController, HomeView {
    
    @IBOutlet weak var recentTransactionsTableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var userNameCharacters: UILabel!
    private var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchRecentTransactions()
        self.recentTransactionsTableView.reloadData()
        setUpUI()
    }
    
    private func setUpTable() {
        
        recentTransactionsTableView.delegate = self
        recentTransactionsTableView.dataSource = self
        recentTransactionsTableView.register(UINib(nibName: "RecentTransactionCell", bundle: nil), forCellReuseIdentifier: "RecentTransactionCell")
        
    }
    private func setUpUI() {
        setUpTable()
        
        presenter = HomePresenter(view: self)
        presenter.fetchRecentTransactions()
        
        userNameLabel.text = UserManager.shared.currentUser?.name
        if let balance = UserManager.shared.currentUser?.balance {
            balanceLabel.text = "\(balance) EGP"
        } else {
            balanceLabel.text = "0.0"
        }
        updateUserInitials(from: userNameLabel.text ?? "")
        
        
    }
     func displayTransactions(transactions: [Transaction]) {
        DispatchQueue.main.async { [weak self] in
            self?.recentTransactionsTableView.reloadData()
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
    func updateUserInitials(from name: String) {
        let components = name.split(separator: " ")
        
        let initials = components.map { $0.prefix(1).uppercased() }.joined()
        
        userNameCharacters.text = initials
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
            navigationItem.backButtonTitle = "Successful Transaction"
        }
    }
}
