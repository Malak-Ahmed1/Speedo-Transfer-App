//
//  NoInternetVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 30/08/2024.
//

import UIKit

class NoInternetVC: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "No Internet")
    }
    

  
    @IBAction func updateBtnClicked(_ sender: Any) {
        
    }
    
}
