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
    @State private var image: Image = Image("man")
    @State private var inputImage: UIImage?
    @State private var showingImagePicker: Bool = false
    @Environment(\.presentationMode) private var presentationMode
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
                .onTapGesture(count: 1) {
                    self.showingImagePicker = true
                }
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
                            presentationMode.wrappedValue.dismiss()
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
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(name.isEmpty)
                    .frame(width: 100, height: 50, alignment: .center)
                }
                .font(.title2)
            }
            Spacer()
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
        AddContactView()
            .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
    }
}

#endif
