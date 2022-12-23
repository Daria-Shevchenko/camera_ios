//
//  CaptureButton.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import SwiftUI

struct CaptureButton: View {
    var tapAction: () -> Void
    var startVideoAction: () -> Void
    var stopVideoAction: () -> Void
    var selectedType: CaptureType

    @State var tapSwitcher = true

    var body: some View {
        Button(action: { captureForSelectedType() }, label: {
            ZStack {
                Circle()
                    .fill(tapSwitcher ? .white : .red)
                    .frame(width: 65, height: 65)
                Circle()
                    .strokeBorder(Color.white, lineWidth: 1)
                    .frame(width: 75, height: 75)
            }
        })
    }

    private func captureForSelectedType() {
        if selectedType == .video {
            if tapSwitcher {
                startVideoAction()
                tapSwitcher = false
            } else {
                stopVideoAction()
                tapSwitcher = true
            }
        } else {
            tapAction()
        }
    }
}

