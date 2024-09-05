//
//  Label+LineHeight.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

class CustomLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLineHeight()
        self.textAlignment = .center

    }
    
    private func applyLineHeight() {
        guard let labelText = text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
