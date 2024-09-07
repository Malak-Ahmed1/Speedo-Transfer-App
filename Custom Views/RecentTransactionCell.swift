//
//  CustomRecentTransactionCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 01/09/2024.
//

import UIKit
class RecentTransactionCell: UITableViewCell {

    
    
    
    
    @IBOutlet weak var reciepentNameLabel: UILabel!
    
    
    @IBOutlet weak var visaInfoLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setUpCell (reciepentName: String, visaInfo: String, date: String, amount: Double) {
        reciepentNameLabel.text = reciepentName
        visaInfoLabel.text = visaInfo
        dateLabel.text = date
        amountLabel.text = "\(amount) EGP"
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
