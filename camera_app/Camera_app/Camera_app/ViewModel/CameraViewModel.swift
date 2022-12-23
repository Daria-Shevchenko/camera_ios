//
//  CameraModel.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 05.12.2022.
//

import AVFoundation
import SwiftUI

final class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate {
    // MARK: - State

    var picData = Data(count: 0)
    let captureTypes: [CaptureType] = [.photo, .video]
    private var position = AVCaptureDevice.Position.back

    @Published var session = AVCaptureSession()
    @Published var output_photo = AVCapturePhotoOutput()
    @Published var output_video = AVCaptureMovieFileOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!

    @Published var isTaken = false
    @Published var alert = false
    @Published var isSaved = false

    @Published var recordedVideoURLs: [URL] = []
    @Published var capturedPhotos: [Photo] = []

    @Published var selectedType: CaptureType = .photo {
        didSet {
            setUp(for: position)
        }
    }

    // MARK: - Actions for photo processing

    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp(for: position)
            return
        case .notDetermined:
            requestPermission()
        case .denied:
            DispatchQueue.main.async {
                self.alert.toggle()
            }
            return
        default:
            return
        }
    }

    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            if granted {
                self.setUp(for: self.position)
            }
        }
    }

    func setUp(for position: AVCaptureDevice.Position) {
        do {
            if let input = session.inputs.first {
                session.removeInput(input)
            }
            if let output = session.outputs.first {
                session.removeOutput(output)
            }
            session.beginConfiguration()
            
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
            }

            if let audioDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .audio, position: position) {
                let audioInput = try AVCaptureDeviceInput(device: audioDevice)
                if session.canAddInput(audioInput) {
                    session.addInput(audioInput)
                }
            }

            if selectedType == .photo {
                if session.canAddOutput(output_photo) {
                    session.addOutput(output_photo)
                }
            } else {
                if session.canAddOutput(output_video) {
                    session.addOutput(output_video)
                }
            }

            session.commitConfiguration()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Actions for video processing

    func takePicture() {
        DispatchQueue.global(qos: .background).async {
            self.output_photo.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
        }
        DispatchQueue.main.async { [unowned self] in
            withAnimation { self.isTaken.toggle() }
            self.isSaved = false
        }
    }

    func retake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
        DispatchQueue.main.async { [unowned self] in
            withAnimation { self.isTaken.toggle() }
            self.isSaved = false
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil { return }
        guard let imageData = photo.fileDataRepresentation() else { return }
        DispatchQueue.main.async { [unowned self] in
            self.picData = imageData
        }
    }

    func savePic() {
        DispatchQueue.main.async { [weak self] in
            guard let data = self?.picData else { return }
            guard let image = UIImage(data: data) else { return }
            self?.isSaved = true
            self?.capturedPhotos.append(Photo(image: image))
        }
    }

    func switchPosition() {
        if position == .back {
            position = .front
            setUp(for: position)
        } else {
            position = .back
            setUp(for: position)
        }
    }

    // MARK: - Actions for video processing

    func startRecording() {
        let tempURL = NSTemporaryDirectory() + "\(Date()).mov"
        output_video.startRecording(to: URL(fileURLWithPath: tempURL), recordingDelegate: self)
    }

    func stopRecording() {
        output_video.stopRecording()
    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print(outputFileURL)
        recordedVideoURLs.append(outputFileURL)
    }
}

extension CameraViewModel {
    private func makeUIView_(_ viewBounds: UIView) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        if !alert {
            preview = AVCaptureVideoPreviewLayer(session: session)
            preview.frame = view.frame

            preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(preview)

            session.startRunning()
        }
        return view
    }

    private func updateUIView_() {}
}
