//
//  Item+CoreDataClass.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

}

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var connection: String?
    @NSManaged public var name: String
    @NSManaged public var photo: Data?
    @NSManaged public var surname: String?

}

extension Item : Identifiable {

}
