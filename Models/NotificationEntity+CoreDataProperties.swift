//
//  NotificationEntity+CoreDataProperties.swift
//  
//
//  Created by 1234 on 08/09/2024.
//
//

import Foundation
import CoreData


extension NotificationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationEntity> {
        return NSFetchRequest<NotificationEntity>(entityName: "NotificationEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var isReceived: Bool
    @NSManaged public var message: String?
    @NSManaged public var timestamp: Date?

}
