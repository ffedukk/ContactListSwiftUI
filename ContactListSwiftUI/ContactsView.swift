//
//  ContentView2.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//


import SwiftUI
import CoreData

struct ContactsView: View {
    
    @EnvironmentObject private var contactsData: CoreDataWorker
    @State private var isAddContactPresented: Bool = false
        
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $contactsData.isDifferentColors.animation()) {
                    Text("Show connections")
                }
                ForEach(contactsData.items) { item in
                    ContactRow(item: item)
                }
                .onDelete(perform: contactsData.deleteItems)
            }
            .toolbar {
                Button(action: {
                    withAnimation {
                        isAddContactPresented.toggle()
                    }
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .navigationTitle("Contact List")
            .navigationBarTitleDisplayMode(.inline)
            .disabled(isAddContactPresented)
        }
        .sheet(isPresented: $isAddContactPresented) {
            AddContactView(isPresented: $isAddContactPresented)
                .environmentObject(contactsData)
                .disableAutocorrection(true)
        }
    }
}

#if DEBUG

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        ContactsView()
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
            .environment(\.colorScheme, .dark)
        ContactsView()
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
        }
    }
}

#endif
