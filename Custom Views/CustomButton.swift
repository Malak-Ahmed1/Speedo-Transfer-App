//
//  CustomButton.swift
//  Speedo Transfer App
//
//  Created by 1234 on 03/09/2024.
//

import UIKit

class CustomButton: UIButton {

    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setup()
       }

    // Custom setup method
      func setup() {
          self.layer.borderWidth = 1
          self.layer.borderColor = UIColor.customPink.cgColor
          self.layer.cornerRadius = 5

      
    }
    

}

