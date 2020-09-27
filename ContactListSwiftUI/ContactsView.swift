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
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
            .animation(.easeIn(duration: 0.5))
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var blur: AnyTransition {
        let setBlur = AnyTransition.move(edge: .top)
            .combined(with: .opacity)
            .animation(.easeInOut(duration: 2))
        return setBlur
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Toggle(isOn: $contactsData.isDifferentColors.animation()) {
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
            .blur(radius: isAddContactPresented ? 40 : 0)
            
            GeometryReader { geometry in
                VStack {
                    if isAddContactPresented {
                        AddContactView(isPresented: $isAddContactPresented)
                            .environmentObject(contactsData)
                            .frame(width: geometry.size.width - 10, height: 500)
                            .cornerRadius(30.0)
                            .padding(5)
                            .animation(.default)
                            .transition(transition)
                            .disableAutocorrection(true)
                        Spacer()
                    }
                }
            }
        }
    }
}

#if DEBUG

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        ContactsView()
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
            .colorScheme(.dark)
        ContactsView()
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
        }
    }
}

#endif
