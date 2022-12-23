//
//  SwitchButton.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import SwiftUI

struct SwitchCameraButton: View {
    var switchAction: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button(action: switchAction, label: {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
            })
            .padding(.trailing, 10)
        }
    }
}
