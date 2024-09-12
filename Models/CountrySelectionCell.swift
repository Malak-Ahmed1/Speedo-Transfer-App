//
//  CountrySelectionCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 12/09/2024.
//

import UIKit

class CountrySelectionCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Make the image circular
        photo.layer.cornerRadius = photo.frame.size.width / 2
        photo.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with country: String, image: UIImage?) {
        title.text = country
        photo.image = image
    }
}
