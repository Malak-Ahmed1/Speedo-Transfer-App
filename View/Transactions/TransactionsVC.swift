import UIKit

protocol TransactionsView: AnyObject {
    func reloadTransactions()
}

class TransactionsVC: UIViewController, TransactionsView {
    
    @IBOutlet weak var transactionsTableView: UITableView!
    private var presenter: TransactionsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        presenter = TransactionsPresenter(view: self)
        presenter.fetchAllTransactions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchAllTransactions()
        
        }
    func setUpTable() {
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.register(UINib(nibName: "TransactionsListCell", bundle: nil), forCellReuseIdentifier: "TransactionsListCell")
    }
    func reloadTransactions() {
        DispatchQueue.main.async { [weak self] in
            self?.transactionsTableView.reloadData()
        }
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    
}

extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTransactionCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionsTableView.dequeueReusableCell(withIdentifier: "TransactionsListCell", for: indexPath) as! TransactionsListCell
        if let transaction = presenter.getTransaction(at: indexPath.row) {
            cell.setUpCell(status: transaction.status!, reciepentName: transaction.recipientName!, visaInfo: transaction.visaInfo!, date: transaction.date!, amount: transaction.amount)
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
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
