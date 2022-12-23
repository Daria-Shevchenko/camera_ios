//
//  CameraPreview.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 05.12.2022.
//

import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    @EnvironmentObject var camera: CameraViewModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        DispatchQueue.main.async {
            self.camera.preview = AVCaptureVideoPreviewLayer(session: self.camera.session)
            self.camera.preview.frame = view.frame
            self.camera.preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(self.camera.preview)
        }
        DispatchQueue.global(qos: .background).async {
            self.camera.session.startRunning()
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
