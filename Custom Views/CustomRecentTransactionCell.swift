//
//  CustomRecentTransactionCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 01/09/2024.
//

import UIKit
class CustomRecentTransactionCell: UITableViewCell {

    
    @IBOutlet weak var visaIconimage: UIImageView!
    
    
    
    @IBOutlet weak var reciepentNameLabel: UILabel!
    
    
    @IBOutlet weak var visaInfoLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setUpCell (visaIcon: UIImage, reciepentName: String, visaInfo: String, date: String, amount: Double) {
        visaIconimage.image = visaIcon
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
