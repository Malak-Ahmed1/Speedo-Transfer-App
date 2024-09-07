import UIKit



class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var recentTransactionArr: [Transaction] = []

    @IBOutlet weak var recentTransactionsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recentTransactionsTable.delegate = self
        recentTransactionsTable.dataSource = self
        
        // Registering the custom cell if not using storyboard prototype cell
        recentTransactionsTable.register(UINib(nibName: "RecentTransactionCell", bundle: nil), forCellReuseIdentifier: "RecentTransactionCell")
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchList() // Reload the transactions list whenever the view appears
        }
    
    @IBAction func notificationBtnClicked(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let notificationsVC = sb.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
        notificationsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(notificationsVC, animated: true)
        navigationItem.title = ""
        notificationsVC.title = "Notifications"
        
    }
    func fetchList() {
        do {
            self.recentTransactionArr = try context.fetch(Transaction.fetchRequest())
            DispatchQueue.main.async {
                self.recentTransactionsTable.reloadData()
            }
        } catch {
            print("Error Fetching")
        }
    }

    @IBAction func viewBtnClicked(_ sender: Any) {
        
        tabBarController?.selectedIndex = 2
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentTransactionArr.count
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = recentTransactionsTable.dequeueReusableCell(withIdentifier: "RecentTransactionCell", for: indexPath) as! RecentTransactionCell
            let data = recentTransactionArr[indexPath.row]
            cell.setUpCell(reciepentName: data.recipientName!, visaInfo: data.visaInfo!, date: data.date!, amount: data.amount)
            
          
            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 77
    }
}
