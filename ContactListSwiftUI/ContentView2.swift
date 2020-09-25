//
//  ContentView2.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//


import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var contactsData: CoreDataWorker
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $contactsData.isDifferentColors) {
                    Text("Change colors")
                }
                
                ForEach(contactsData.items) { item in
                        ContactRow(item: item)
                }
                .onDelete(perform: contactsData.deleteItems)
            }
            .toolbar {
                Button(action: {
                    withAnimation {
                        contactsData.addItem()
                    }
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
                
            }
            .navigationTitle("Contact List")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
    }
}

