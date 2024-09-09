//
//  SecondStepPresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 09/09/2024.
//

import Foundation
import UIKit
import CoreData

protocol SecondStepProtocol: AnyObject{
    
 func confirmTransaction(recipientName: String?, firstAmount: String?)

}


class SecondStepPresenter {
    private weak var view: SecondStepView?
    private let context: NSManagedObjectContext

    init(view: SecondStepView, context: NSManagedObjectContext) {
        self.view = view
        self.context = context
    }
    
    
    
    private func addNotification(for transaction: Transaction) {
        let newNotification = NotificationEntity(context: context)
        if transaction.status == "Failed" {
            newNotification.message = "You received \(transaction.amount) from \(transaction.recipientName ?? "someone")."
        } else {
            newNotification.message = "You sent \(transaction.amount) to \(transaction.recipientName ?? "someone")."
        }
        newNotification.timestamp = Date()

        do {
            try context.save()
        } catch {
            view?.displayError("Error saving notification: \(error)")
        }
    }
}

extension SecondStepPresenter: SecondStepProtocol {
    
    func confirmTransaction(recipientName: String?, firstAmount: String?) {
        guard let recipient = recipientName, !recipient.isEmpty else {
            view?.displayError("Recipient name is missing.")
            return
        }
        
//        guard let amountText = firstAmount else {
//            view?.displayError("Invalid or missing amount.")
//            return
//        }
        

        let newTransaction = Transaction(context: context)
        newTransaction.recipientName = recipient
        newTransaction.visaInfo = "Visa . Master Card . 1234"
        newTransaction.status = "Successful"
        newTransaction.amount = 100 //To.Do set actual amount

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        newTransaction.date = dateFormatter.string(from: Date())
        
        do {
            try context.save()
            view?.showSuccessMessage("Transaction successfully saved.")
        } catch {
            view?.displayError("Error saving transaction: \(error)")
        }
        
        addNotification(for: newTransaction)
        LocalNotificationManager.shared.scheduleNotification(title: "Notification", body: "Successful Transfer", triggerDate: Date().addingTimeInterval(3))
    }
  
}
