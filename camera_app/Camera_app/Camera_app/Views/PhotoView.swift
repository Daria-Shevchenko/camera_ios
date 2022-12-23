//
//  PhotoView.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 07.12.2022.
//

import SwiftUI

struct PhotoView: View {
    // MARK: - Properties

    var photo: Photo

    // MARK: - Init

    var body: some View {
        Image(uiImage: photo.image)
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
}
