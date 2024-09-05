//
//  SecondStepVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit

class SecondStepVC: UIViewController {
    
    @IBOutlet weak var firstAmountLabel: UILabel!
    weak var delegate: StepNavigationDelegate?

    @IBOutlet weak var secondAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }
    
    @IBAction func confirmBtnClicked(_ sender: Any) {
        delegate?.goToNextStep(currentStep: self)
    }
    
    @IBAction func previousBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
        
    }
}
