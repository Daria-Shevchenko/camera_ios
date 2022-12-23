//
//  CameraView.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import SwiftUI

struct CameraView: View {
    // MARK: - Properties

    let alertTitle = "Please enable camera or microphone access!"

    // MARK: - Dependencies

    @EnvironmentObject var camera: CameraViewModel

    var body: some View {
        ZStack {
            CameraPreview()
                .environmentObject(camera)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                cameraControls
                typePicker
            }
        }
        .onAppear(perform: camera.checkPermission)
        .alert(isPresented: $camera.alert) {
            Alert(title: Text(alertTitle))
        }
    }

    @ViewBuilder
    private var cameraControls: some View {
        ZStack {
            if camera.isTaken {
                SavePictureButton(savePic: camera.savePic, isSaved: camera.isSaved)
                RetakeButton(retakeAction: camera.retake)
            } else {
                CaptureButton(tapAction: camera.takePicture,
                              startVideoAction: camera.startRecording,
                              stopVideoAction: camera.stopRecording,
                              selectedType: camera.selectedType)
                ZStack {
                    SwitchCameraButton(switchAction: camera.switchPosition)
                }
            }
        }
        .frame(height: 75)
    }

    @ViewBuilder
    private var typePicker: some View {
        if !camera.isTaken {
            Picker("Choose capture type", selection: $camera.selectedType) {
                ForEach(camera.captureTypes, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}
