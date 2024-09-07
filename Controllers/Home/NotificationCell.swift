//
//  NotificationCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 07/09/2024.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var transactionType: UILabel!
    
    
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // In(itialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(transactionType: String, message: String, transactionDate: String) {
        
        self.transactionType.text = transactionType
        transactionInfo.text = message
        self.transactionDate.text = transactionDate
    }
    
}
