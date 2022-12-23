//
//  VideoCard.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import SwiftUI

struct VideoCard: View {
    var image: UIImage?

    var body: some View {
        ZStack {
            Image(uiImage: (image ?? UIImage(systemName: "questionmark"))!)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 180)
                .background(.black)
                .cornerRadius(10)
                .overlay {
                    Image(systemName: "play.fill")
                }
        }
    }
}
