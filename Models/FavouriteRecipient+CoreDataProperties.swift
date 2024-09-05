//
//  FavouriteRecipient+CoreDataProperties.swift
//  
//
//  Created by 1234 on 04/09/2024.
//
//

import Foundation
import CoreData


extension FavouriteRecipient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteRecipient> {
        return NSFetchRequest<FavouriteRecipient>(entityName: "FavouriteRecipient")
    }

    @NSManaged public var userName: String?
    @NSManaged public var accountNumber: String?

}
