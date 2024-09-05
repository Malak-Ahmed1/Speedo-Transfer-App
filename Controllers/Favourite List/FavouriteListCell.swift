//
//  FavouriteListCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 03/09/2024.
//

import UIKit

class FavouriteListCell: UITableViewCell {

    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var accountNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell (userName: String, accountNumber: String) {
    
    
        self.userName.text = userName
        self.accountNumber.text = accountNumber
      
    }
}
