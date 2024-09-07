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

    override func viewDidLoad() {
        super.viewDidLoad()
        if let transaction = transaction {
            
            
            // will be as api
            
            transferType.text = transaction.status
            senderNameLabel.text = transaction.recipientName
            senderAccountLabel.text = transaction.visaInfo
            recipientNameLabel.text = transaction.recipientName
            dateLabel.text = transaction.date
            transactionIdLabel.text = "123456"
            recipientAccountLabel.text = transaction.visaInfo
        }
    }
}
