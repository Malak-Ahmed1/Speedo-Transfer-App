import UIKit

protocol HomeView: AnyObject {
    
    func displayTransaction(transactions: [Transaction])
}

class HomeVC: UIViewController,HomeView {
    
    
    var presenter: HomePresenterProtocol!
    
    
    @IBOutlet weak var recentTransactionsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter = HomePresenter(view: self)
        presenter.getRecentTransactions()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getRecentTransactions()
    }
    func setupTableView() {
        recentTransactionsTable.delegate = self
        recentTransactionsTable.dataSource = self
        recentTransactionsTable.register(UINib(nibName: "RecentTransactionCell", bundle: nil), forCellReuseIdentifier: "RecentTransactionCell")
    }
    @IBAction func notificationBtnClicked(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let notificationsVC = sb.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        notificationsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(notificationsVC, animated: true)
        navigationItem.title = ""
        notificationsVC.title = "Notifications"
        
    }
    
    @IBAction func viewBtnClicked(_ sender: Any) {
        
        tabBarController?.selectedIndex = 2
    }
    
    func displayTransaction(transactions: [Transaction]) {
        DispatchQueue.main.async {
            self.recentTransactionsTable.reloadData()
        }
    }
    
    
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getTransactionCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentTransactionsTable.dequeueReusableCell(withIdentifier: "RecentTransactionCell", for: indexPath) as! RecentTransactionCell
        let data = self.presenter.getTransactionArr()[indexPath.row]
        cell.setUpCell(reciepentName: data.recipientName!, visaInfo: data.visaInfo!, date: data.date!, amount: data.amount)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 77
    }
}
