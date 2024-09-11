//
//  Transaction+CoreDataProperties.swift
//  
//
//  Created by 1234 on 07/09/2024.
//
//

import Foundation
import CoreData


extension Transaction {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var recipientName: String?
    @NSManaged public var visaInfo: String?
    @NSManaged public var date: String?
    @NSManaged public var amount: Double
    @NSManaged public var status: String?
    @NSManaged public var email: String?

}
