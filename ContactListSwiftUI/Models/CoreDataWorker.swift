//
//  CoreDataWorker.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataWorker: ObservableObject {
    
    @Published private var managedItems: [Item] = []
    @Published var isDifferentColors = false
    
    var viewContext: NSManagedObjectContext
    
    var items: [Item] {
        get {
            let result = managedItems
            return result.sorted { (x, y) -> Bool in
                x.name > y.name
            }
        } set {
            managedItems = newValue
        }
    }
    
    
    init(_ context: NSManagedObjectContext) {
        self.viewContext = context
        managedItems = self.fetch()
    }
    
    func addItem(name: String, surname: String, connection: String, photo: Bool) {
        let newItem = Item(context: viewContext)
        newItem.name = name
        newItem.surname = surname
        newItem.connection = connection
        if photo {
            let UIimgData = UIImage(named: "turtlerock")?.jpegData(compressionQuality: 1)
                    newItem.photo = UIimgData
        }
        do {
            items.append(newItem)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(viewContext.delete)
        do {
            items.remove(atOffsets: offsets)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetch() -> [Item] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            return try viewContext.fetch(fetchRequest) as! [Item]
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
