import UIKit


protocol NotificationView: AnyObject {
    
    func displayNotifications()
}

class NotificationsVC: UIViewController, NotificationView {
   
    

    @IBOutlet weak var notificationsTable: UITableView!

    var presenter: NotificatoinProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()
        presenter = NotificationPresenter(view: self)
        presenter.getNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getNotifications()
        
        }
    
    func setUpTable() {
        notificationsTable.delegate = self
        notificationsTable.dataSource = self
        notificationsTable.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
    }
    
    func displayNotifications() {
            DispatchQueue.main.async {
                self.notificationsTable.reloadData()
            }
    }
    

    @IBAction func backBtnClicked(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }

}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNotificationsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        let notification = self.presenter.getNotificationArr()[indexPath.row]
        cell.setUpCell(transactionType: "Received", message: notification.message!, transactionDate: "date")
        cell.backgroundColor = .clear
        return cell
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
    

