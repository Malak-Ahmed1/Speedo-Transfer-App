//
//  FavouritesCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 06/09/2024.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
    var deleteAction: (() -> Void)?
    var editAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteAction?()
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        editAction?()
    }
    
    func setUpCell(userName: String, accountNumber: String) {
        userNameLabel.text = userName
        accountNumberLabel.text = accountNumber
    }
}


