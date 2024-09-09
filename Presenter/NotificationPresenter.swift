//
//  NotificationPresenter.swift
//  Speedo Transfer App
//
//  Created by 1234 on 08/09/2024.
//

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
    
    var view: NotificationView?
    
    init(view: NotificationView)
    {
        self.view = view
    }
}


extension NotificationPresenter: NotificatoinProtocol {
   
    
    func getNotifications() {
        do {
            self.notificationArr = try context.fetch(NotificationEntity.fetchRequest())
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
    

