import Foundation

import UIKit

class TransactionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var transactionsTableView: UITableView!
    var transactionArr: [Transaction] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.register(UINib(nibName: "TransactionsListCell", bundle: nil), forCellReuseIdentifier: "TransactionsListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchList() // Reload the transactions list whenever the view appears
    }

    func fetchList() {
        do {
            self.transactionArr = try context.fetch(Transaction.fetchRequest())
            DispatchQueue.main.async {
                self.transactionsTableView.reloadData()
            }
        } catch {
            print("Error Fetching")
        }
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionsTableView.dequeueReusableCell(withIdentifier: "TransactionsListCell", for: indexPath) as! TransactionsListCell
        let data = transactionArr[indexPath.row]
        cell.setUpCell(status: data.status!, reciepentName: data.recipientName!, visaInfo: data.visaInfo!, date: data.date!, amount: data.amount)
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTransaction = transactionArr[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionInfoVC = storyboard.instantiateViewController(withIdentifier: "TransactionInfoVC") as! TransactionInfoVC
        transactionInfoVC.transaction = selectedTransaction
        navigationController?.pushViewController(transactionInfoVC, animated: true)
        navigationItem.backButtonTitle = "Successful Transaction"
        
       
    }
    
}
