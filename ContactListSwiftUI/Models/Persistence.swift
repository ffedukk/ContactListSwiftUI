//
//  Persistence.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 22.09.2020.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    #if DEBUG
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let UIimgData = UIImage(named: "turtlerock")?.jpegData(compressionQuality: 1)
        
        let newItem1 = Item(context: viewContext)
        newItem1.name = "Rodger"
        newItem1.surname = "Federer"
        newItem1.connection = "Work"
        
        newItem1.photo = UIimgData
        
        let newItem2 = Item(context: viewContext)
        newItem2.name = "Grigor"
        newItem2.connection = "Family"
        
        let newItem3 = Item(context: viewContext)
        newItem3.name = "Alexandr"
        newItem3.surname = "Zverev"
        
        let newItem4 = Item(context: viewContext)
        newItem4.name = "Daniil"
        newItem4.connection = "Study"
        newItem4.photo = UIimgData

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    #endif
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ContactListSwiftUI")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
