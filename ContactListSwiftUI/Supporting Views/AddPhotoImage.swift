//
//  AddPhotoImage.swift
//  ContactListSwiftUI
//
//  Created by 18592232 on 27.09.2020.
//

import SwiftUI

struct AddPhotoImage: View {
    
    var image: Image
    
    var body: some View {
        image.resizable()
            .scaledToFill()
            .frame(width: 100, height: 100, alignment: .center)
            .clipShape(Circle())
    }
}

#if DEBUG

struct AddPhotoImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddPhotoImage(image: Image("man"))
            AddPhotoImage(image: Image("clouds"))
        }
        .previewLayout(.fixed(width: 200, height: 200))
    }
}

#endif
