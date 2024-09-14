import UIKit

class TransactionsListCell: UITableViewCell {

    @IBOutlet weak var recipientNameLabel: UILabel!
    @IBOutlet weak var visaInfoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCell(status: String, reciepentName: String, visaInfo: String, date: String, amount: Double) {
        statusLabel.text = status
        if status == "Successful" {
            statusView.backgroundColor = UIColor(displayP3Red: 234/255, green: 243/255, blue: 236/255, alpha: 1)
        } else {
            statusView.backgroundColor = UIColor(displayP3Red: 255/255, green: 239/255, blue: 239/255, alpha: 1)
        }
        
        recipientNameLabel.text = reciepentName
        visaInfoLabel.text = visaInfo
        dateLabel.text = date
        amountLabel.text = "\(amount) EGP"
    }
}
