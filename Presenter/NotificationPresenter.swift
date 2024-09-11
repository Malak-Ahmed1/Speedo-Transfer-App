import Foundation
import UIKit
import CoreData

protocol NotificatoinProtocol: AnyObject {
    var notificationArr: [NotificationEntity] { get }
    func getNotifications()
    func getNotificationsCount() -> Int
    func getNotificationArr() -> [NotificationEntity]
}

class NotificationPresenter {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notificationArr: [NotificationEntity] = []
    
    weak var view: NotificationView?
    private var userEmail: String
    
    init(view: NotificationView, userEmail: String) {
        self.view = view
        self.userEmail = userEmail
    }
}

extension NotificationPresenter: NotificatoinProtocol {
    
    func getNotifications() {
        let request: NSFetchRequest<NotificationEntity> = NotificationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", userEmail)
        
        do {
            self.notificationArr = try context.fetch(request)
            DispatchQueue.main.async { [weak self] in
                self?.view?.displayNotifications()
            }
        } catch {
            print("Error fetching notifications: \(error)")
        }
    }
    
    func getNotificationsCount() -> Int {
        
        
        
        return notificationArr.count
    }
    
    func getNotificationArr() -> [NotificationEntity] {
        return notificationArr
    }
}
