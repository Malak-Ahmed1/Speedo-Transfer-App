import UIKit

struct Recent {
    var icon: UIImage
    var recipientName: String
    var visaInfo: String
    var date: String
    var amount: Double
}

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arr: [Recent] = []

    @IBOutlet weak var recentTransactionsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recentTransactionsTable.delegate = self
        recentTransactionsTable.dataSource = self
        
        // Registering the custom cell if not using storyboard prototype cell
        recentTransactionsTable.register(UINib(nibName: "CustomRecentTransactionCell", bundle: nil), forCellReuseIdentifier: "CustomRecentTransactionCell")

        if let visaIcon = UIImage(named: "Visa") {
            arr.append(Recent(icon: visaIcon, recipientName: "Malak Ahmed", visaInfo: "Visa MasterCard. 1234", date: "Today 12:24 AM", amount: 500))
            arr.append(Recent(icon: visaIcon, recipientName: "Ahmed Mohammed", visaInfo: "Visa MasterCard. 1234", date: "Today 12:24 AM", amount: 300))
            arr.append(Recent(icon: visaIcon, recipientName: "Ahmed Mohammed", visaInfo: "Visa MasterCard. 1234", date: "Today 12:24 AM", amount: 100))
            arr.append(Recent(icon: visaIcon, recipientName: "Walled Mostafa", visaInfo: "Visa MasterCard. 1234", date: "Today 12:24 AM", amount: 1200))
            arr.append(Recent(icon: visaIcon, recipientName: "Ahmed Mohammed", visaInfo: "Visa MasterCard. 1234", date: "Today 12:24 AM", amount: 300))
            arr.append(Recent(icon: visaIcon, recipientName: "Ahmed Mohammed", visaInfo: "Visa MasterCard. 1234", date: "Today 12:24 AM", amount: 300))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentTransactionsTable.dequeueReusableCell(withIdentifier: "CustomRecentTransactionCell", for: indexPath) as! CustomRecentTransactionCell
        let data = arr[indexPath.row]
        cell.setUpCell(visaIcon: data.icon, reciepentName: data.recipientName, visaInfo: data.visaInfo, date: data.date, amount: data.amount)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 77
    }
}
