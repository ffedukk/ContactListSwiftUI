//
//  CoreDataWorker.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//

import SwiftUI
import CoreData

class CoreDataWorker: ObservableObject {
    
    @Published var items: [Item] = []
    @Published var isDifferentColors: Bool = false
    var viewContext: NSManagedObjectContext
    
    init(_ context: NSManagedObjectContext) {
        self.viewContext = context
        items = self.fetch().sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    func addItem(name: String, surname: String?, connection: String?, photo: UIImage?) {
        let newItem = Item(context: viewContext)
        newItem.name = name
        newItem.surname = surname
        newItem.connection = connection
        if let photo = photo {
            let UIimgData = photo.jpegData(compressionQuality: 1)
            newItem.photo = UIimgData
        }
        do {
            items.append(newItem)
            items.sort { $0.name.lowercased() < $1.name.lowercased() }
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
    
    private func fetch() -> [Item] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            return try viewContext.fetch(fetchRequest) as! [Item]
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
