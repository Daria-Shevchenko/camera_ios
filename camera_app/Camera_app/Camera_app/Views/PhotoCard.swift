//
//  PhotoCard.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 07.12.2022.
//

import SwiftUI

struct PhotoCard: View {
    var image: Photo?

    var body: some View {
        ZStack {
            Image(uiImage: (image?.image ?? UIImage(systemName: "questionmark"))!)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 180)
                .background(.black)
                .cornerRadius(10)
        }
    }
}
