//
//  ThirdStepVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

class ThirdStepVC: UIViewController {

    weak var delegate: StepNavigationDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favArr: [FavouriteRecipient] = []
    
    @IBOutlet weak var recipientNameLabel: UILabel!
    
    @IBOutlet weak var recipientAccountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func backBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }
    
    @IBAction func toHomeBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }
    
    
    @IBAction func addFavouriteBtnclicked(_ sender: Any) {
        
        self.showAlert(title: "Sure?", message: "Are you sure you want add this user to favourites?", okHandler: {
            let newFavRecipient = FavouriteRecipient(context: self.context)
            newFavRecipient.userName = self.recipientNameLabel.text
            newFavRecipient.accountNumber = self.recipientAccountLabel.text
            
            do {
                
                try self.context.save()
            } catch {
                print("Error")
            }

        }, cancelHandler: {
            
            
        })
        
        
    }
}
