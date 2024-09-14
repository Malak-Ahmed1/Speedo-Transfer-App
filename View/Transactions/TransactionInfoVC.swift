import UIKit

class TransactionInfoVC: UIViewController {

    var transaction: Transaction?

    @IBOutlet weak var transferType: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var senderAccountLabel: UILabel!
    @IBOutlet weak var recipientNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionIdLabel: UILabel!
    @IBOutlet weak var recipientAccountLabel: UILabel!

    @IBOutlet weak var amountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let transaction = transaction {
            
            
            
            transferType.text = transaction.status
            senderNameLabel.text = UserManager.shared.currentUser?.name
            senderAccountLabel.text = "Visa . Master Card . 1234"
            recipientNameLabel.text = transaction.recipientName
            dateLabel.text = transaction.date
            transactionIdLabel.text = "123456"
            recipientAccountLabel.text = transaction.visaInfo
            amountLabel.text = "\(transaction.amount)"
        }
    }
}
