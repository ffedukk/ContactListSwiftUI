//
//  AddContactView.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 25.09.2020.
//

import SwiftUI

struct AddContactView: View {
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var connection: String = ""
    @State var image: Image = Image("man")
    @State private var inputImage: UIImage?
    @State private var showingImagePicker: Bool = false
    @Binding var isPresented: Bool
    @EnvironmentObject private var contactsData: CoreDataWorker
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Text("Add Contact")
                .font(.title)
            
            AddPhotoImage(image: image)
                .onTapGesture(count: 1, perform: {
                    self.showingImagePicker = true
                })
            VStack(alignment: .leading, spacing: 20) {
                Divider()
                Group {
                    TextField("name", text: $name)
                    TextField("surename", text: $surname)
                    TextField("connection", text: $connection)
                }
                .frame(height: 35, alignment: .center)
                .font(Font.system(size: 20, design: .default))
                
                Divider()
                HStack(alignment: .top) {
                    Button("Cancel") {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }
                    .frame(width: 100, height: 50, alignment: .center)
                    Spacer()
                    Button("Add") {
                        withAnimation {
                            contactsData.addItem(name: name,
                                                 surname: surname.isEmpty ? nil : surname,
                                                 connection: connection.isEmpty ? nil : surname,
                                                 photo: inputImage)
                            isPresented.toggle()
                        }
                    }
                    .disabled(name.isEmpty)
                    .frame(width: 100, height: 50, alignment: .center)
                }
                .font(.title2)
            }
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

#if DEBUG

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

#endif
