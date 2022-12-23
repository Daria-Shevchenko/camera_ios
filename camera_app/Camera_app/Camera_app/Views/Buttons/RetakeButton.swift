//
//  RetakeButton.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import SwiftUI

struct RetakeButton: View {
    var retakeAction: () -> Void
    private let label = "Retake photo"

    var body: some View {
        HStack {
            Spacer()
            Button(action: retakeAction, label: {
                Text(label)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Capsule())
            })
            .padding(.trailing, 10)
        }
    }
}
