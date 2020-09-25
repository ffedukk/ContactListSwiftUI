//
//  ContactListSwiftUIApp.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 22.09.2020.
//

import SwiftUI

@main
struct ContactListSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContactsView()
                .environmentObject(CoreDataWorker(persistenceController.container.viewContext))
        }
    }
}
