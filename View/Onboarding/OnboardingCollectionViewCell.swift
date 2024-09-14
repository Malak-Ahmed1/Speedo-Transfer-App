//
//  OnboardingCollectionViewCell.swift
//  Speedo Transfer App
//
//  Created by 1234 on 30/08/2024.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    
    @IBOutlet weak var slideTitleLabel: UILabel!
    
    @IBOutlet weak var slideDescriptionLabel: UILabel!
 
    
    
    func setUp(_ slide: OnboardingSlide) {
        
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
        
    }
}
