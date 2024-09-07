import UIKit

class NotificationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notificationsTable: UITableView!
    var notificationArr: [NotificationEntity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationsTable.delegate = self
        notificationsTable.dataSource = self
        notificationsTable.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchNotifications()
        }
    
    func fetchNotifications() {
        do {
            self.notificationArr = try context.fetch(NotificationEntity.fetchRequest())
            DispatchQueue.main.async {
                self.notificationsTable.reloadData()
            }
        } catch {
            print("Error fetching notifications: \(error)")
        }
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        let notification = notificationArr[indexPath.row]
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
