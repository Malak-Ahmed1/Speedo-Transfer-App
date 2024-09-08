//
//  SecondStepVC.swift
//  Speedo Transfer App
//
//  Created by 1234 on 31/08/2024.
//

import UIKit


class SecondStepVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: StepNavigationDelegate?

    @IBOutlet weak var firstAmountLabel: UILabel!
    @IBOutlet weak var secondAmountLabel: UILabel!
    @IBOutlet weak var recipientNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }

    @IBAction func confirmBtnClicked(_ sender: Any) {
        delegate?.goToNextStep(currentStep: self)
        
        // Create and save the transaction
        let newTransaction = Transaction(context: self.context)
        newTransaction.recipientName = self.recipientNameLabel.text
        newTransaction.visaInfo = "Visa . Master Card . 1234"
        newTransaction.status = "Successful"
        
        if let amountText = firstAmountLabel.text, let amount = Double(amountText) {
            newTransaction.amount = amount
        } else {
            print("Invalid amount or conversion failed.")
        }

        // Get current date and format it
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        let formattedDate = dateFormatter.string(from: Date())
        newTransaction.date = formattedDate
        
        do {
            try self.context.save()
        } catch {
            print("Error saving transaction: \(error)")
        }
        
        // Add notification for the new transaction
        addNotification(for: newTransaction)
        
        // Schedule local notification
        LocalNotificationManager.shared.scheduleNotification(title: "Notification", body: "Successful Transfer", triggerDate: Date().addingTimeInterval(3))
    }

    @IBAction func previousBtnClicked(_ sender: Any) {
        delegate?.goToPreviousStep(currentStep: self)
    }

    func addNotification(for transaction: Transaction) {
        
        let newNotification = NotificationEntity(context: self.context)
        // Check for transaction type
        if transaction.status == "Failed" {
            newNotification.message = "You received \(transaction.amount) from \(transaction.recipientName ?? "someone")."
        } else {
            newNotification.message = "You sent \(transaction.amount) to \(transaction.recipientName ?? "someone")."
        }
        newNotification.timestamp = Date()
        
        do {
            try context.save()
        } catch {
            print("Error saving notification: \(error)")
        }
    }
}
