//
//  Data.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 23.09.2020.
//

import UIKit
import SwiftUI
import CoreData

let itemsData: [Item] = fetch()

func fetch() -> [Item] {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")

    return try! PersistenceController.shared.container.viewContext.fetch(fetchRequest) as! [Item]
}



