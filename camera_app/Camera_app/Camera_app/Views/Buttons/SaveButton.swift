//
//  SaveButton.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import SwiftUI

struct SavePictureButton: View {
    var savePic: () -> Void
    var isSaved: Bool

    var body: some View {
        Button(action: { if !isSaved { savePic() } }, label: {
            Text(isSaved ? "Saved" : "Save")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
        })
        .padding(.leading, 10)
    }
}
