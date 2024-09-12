import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var transactionType: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCell(transactionType: String, message: String, transactionDate: String) {
        self.transactionType.text = transactionType
        self.transactionInfo.text = message
        self.transactionDate.text = transactionDate
    }
}
