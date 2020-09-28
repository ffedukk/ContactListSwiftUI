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
    @State private var chosenConnection = 0
    private var connections = ["None", "Work", "Family", "Study"]
    @State private var image: Image = Image("man")
    @State private var inputImage: UIImage?
    @State private var showingImagePicker: Bool = false
    @State private var showingActionSheet: Bool = false
    @State private var source: UIImagePickerController.SourceType = .photoLibrary
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
                    showingActionSheet = true
                }
                
            VStack(alignment: .leading, spacing: 20) {
                Divider()
                Group {
                    TextField("name", text: $name)
                    TextField("surename", text: $surname)
                    Picker(selection: $chosenConnection, label: Text(connections[chosenConnection])) {
                        ForEach(0..<connections.count) { index in
                            Text(self.connections[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
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
                                                 connection: chosenConnection == 0 ? nil : connections[chosenConnection],
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
            ImagePicker(image: self.$inputImage, source: source)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Choose a photo") ,buttons: [.default(Text("Take a photo")) {
                source = .camera
                showingImagePicker = true
            }, .default(Text("From Library")) {
                source = .photoLibrary
                showingImagePicker = true
            }, .cancel()])
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
