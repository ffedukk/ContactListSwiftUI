//
//  AddContactView.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//

import SwiftUI

struct AddContactView: View {
    
    @State private var name = ""
    @State private var surname = ""
    @State private var connection = ""
    @Binding var isPresented: Bool
    @EnvironmentObject var contactsData: CoreDataWorker
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Text("Add Contact")
                .font(.title)
            VStack(alignment: .leading, spacing: 20) {
                TextField("name", text: $name)
                TextField("surename", text: $surname)
                TextField("connection", text: $connection)
                Spacer()
                HStack {
                    Button("Cancel") {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    Spacer()
                    Button("Add") {
                        withAnimation {
                            contactsData.addItem(name: name, surname: surname, connection: connection, photo: true)
                            isPresented = false
                        }
                        
                    }
                    .disabled(name.isEmpty)
                }
                .font(.title2)
            }
        }
        .padding()
    }
    
}




struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsViewSpy()
    }
}

private struct ContactsViewSpy: View {
    @State var boolian = true
    var body: some View {
        AddContactView(isPresented: $boolian)
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
    }
}
