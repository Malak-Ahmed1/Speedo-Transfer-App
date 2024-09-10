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

    private func incrementPoints() {
        PointsManager.shared.incrementPoints(by: 500)
    }
}

extension SecondStepPresenter: SecondStepProtocol {
    func confirmTransaction(recipientName: String?, firstAmount: String?) {
        guard let recipient = recipientName, !recipient.isEmpty else {
            view?.displayError("Recipient name is missing.")
            return
        }

        // Convert firstAmount to Double
        guard let amountString = firstAmount, let amount = Double(amountString) else {
            view?.displayError("Invalid or missing amount.")
            return
        }

        let newTransaction = Transaction(context: context)
        newTransaction.recipientName = recipient
        newTransaction.visaInfo = "Visa . Master Card . 1234"
        newTransaction.status = "Successful"
        newTransaction.amount = amount // Set the converted amount

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        newTransaction.date = dateFormatter.string(from: Date())

        do {
            try context.save()
            view?.showSuccessMessage("Transaction successfully saved.")
            incrementPoints()
        } catch {
            view?.displayError("Error saving transaction: \(error)")
        }

        addNotification(for: newTransaction)
        LocalNotificationManager.shared.scheduleNotification(title: "Notification", body: "Successful Transfer", triggerDate: Date().addingTimeInterval(3))
    }
}

