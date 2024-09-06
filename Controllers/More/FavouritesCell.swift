//
//  FavouritesCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 06/09/2024.
//

import UIKit

protocol FavouritesCellDelegate: AnyObject {
    func didTapDeleteButton(on cell: FavouritesCell)
    func didTapEditButton(on cell: FavouritesCell)
}

class FavouritesCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    weak var delegate: FavouritesCellDelegate?

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
  
    @IBAction func deleteBtnClicked(_ sender: Any) {
        
        delegate?.didTapDeleteButton(on: self)
        
    }
    @IBAction func editBtnClicked(_ sender: Any) {
        delegate?.didTapEditButton(on: self)
    
 }
}

