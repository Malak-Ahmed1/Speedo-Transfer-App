import Foundation
import UIKit
import CoreData


protocol SecondStepProtocol: AnyObject {
    func confirmTransaction(recipientName: String?, firstAmount: String?)
}

class SecondStepPresenter {
    private weak var view: SecondStepView?
    private let context: NSManagedObjectContext

    init(view: SecondStepView, context: NSManagedObjectContext) {
        self.view = view
        self.context = context
    }

    // Save Core Data context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            view?.displayError("Error saving context: \(error.localizedDescription)")
        }
    }

    // Add notification for the transaction
    private func addNotification(for transaction: Transaction) {
        let newNotification = NotificationEntity(context: context)
        if transaction.status == "Failed" {
            newNotification.message = "You received \(transaction.amount) from \(transaction.recipientName ?? "someone")."
        } else {
            newNotification.message = "You sent \(transaction.amount) to \(transaction.recipientName ?? "someone")."
        }
        newNotification.timestamp = Date()
        newNotification.email = UserManager.shared.currentUser?.email
        saveContext() // Save after adding the notification
    }

    // Increment points
    private func incrementPoints() {
        PointsManager.shared.incrementPoints(by: 500)
        
    }
}

extension SecondStepPresenter: SecondStepProtocol {
    // Confirm and process a transaction
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

        // Create a new transaction
        let newTransaction = Transaction(context: context)
        newTransaction.recipientName = recipient
        newTransaction.visaInfo = "Visa . Master Card . 1234"
        newTransaction.status = "Successful"
        newTransaction.amount = amount
        newTransaction.email = UserManager.shared.currentUser?.email

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        newTransaction.date = dateFormatter.string(from: Date())

        do {
            try context.save()
            view?.showSuccessMessage("Transaction successfully saved.")
            UserManager.shared.currentUser?.balance! -= amount
            incrementPoints()
        } catch {
            view?.displayError("Error saving transaction: \(error.localizedDescription)")
        }

        // Add a notification for the transaction
        addNotification(for: newTransaction)

        // Schedule a local notification
        LocalNotificationManager.shared.scheduleNotification(
            title: "Notification",
            body: "Successful Transfer",
            triggerDate: Date().addingTimeInterval(3)
        )
    }
}
