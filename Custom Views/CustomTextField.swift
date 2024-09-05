//
//  CustomTextField.swift
//  Speedo Transfer App
//
//  Created by 1234 on 03/09/2024.
//

import UIKit

class CustomTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           // Apply customizations here
           setup()
       }

    // Custom setup method
      func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 8
        self.clipsToBounds = true

      
    }
}
