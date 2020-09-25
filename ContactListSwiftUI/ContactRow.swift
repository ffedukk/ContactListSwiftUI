//
//  ContactRow.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 22.09.2020.
//

import SwiftUI

struct ContactRow: View {
    
    @EnvironmentObject var contactData: CoreDataWorker
    @State var color = Color.red
    
    var item: Item
    var itemIndex: Int {
        contactData.items.firstIndex(where: { $0.id == item.id })!
    }
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
            .animation(.easeInOut(duration: 0.3))
        let removal = AnyTransition.scale
            .combined(with: .opacity)
            .animation(.easeInOut(duration: 0.3))
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var body: some View {
        HStack {
            if let photo = item.photo {
                let UIimage = UIImage(data: photo)
                Image(uiImage: UIimage!)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .bold()
                    .font(.title2)
                if let surname = item.surname {
                    Text(surname)
                        .font(.subheadline)
                }
            }
            Spacer()
            if contactData.isDifferentColors {
                if let connection = item.connection {
                    Text(connection)
                        .italic()
                        .font(.subheadline)
                        .foregroundColor(color)
                        .transition(transition)
                }
            }
        }
        .padding()
        .contextMenu{
            Button(action:{
                self.color = Color.blue
            }){
                HStack {
                    Image(systemName: "pencil.tip.crop.circle")
                    Text("Set color to blue")
                }
            }
            Button(action:{
                self.color = Color.red
            }){
                HStack {
                    Image(systemName: "pencil.tip.crop.circle")
                    Text("Set color to red")
                }
            }
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContactRow(item: CoreDataWorker(PersistenceController.preview.container.viewContext).items[1])
            ContactRow(item: CoreDataWorker(PersistenceController.preview.container.viewContext).items[3])
        }
        .previewLayout(.fixed(width: 400 ,height: 150))
        .environmentObject(CoreDataWorker(PersistenceController.preview.container.viewContext))
    }
}
