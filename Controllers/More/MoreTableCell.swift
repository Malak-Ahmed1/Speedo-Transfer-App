//
//  MoreTableCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 05/09/2024.
//

import UIKit

class MoreTableCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(image: UIImage, title: String) {
        
        cellImage.image = image
        titleLabel.text = title
        
    }
    
}
