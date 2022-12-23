//
//  ContentView.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 03.12.2022.
//

import AVFoundation
import AVKit
import SwiftUI

struct Main: View {
    // MARK: - State

    let columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    @StateObject var videoManager = VideoManager()
    @StateObject var camera = CameraViewModel()

    var body: some View {
        NavigationView {
            VStack {
                gallery
                cameraButton
            }
            .navigationTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private var gallery: some View {
        ScrollView {
            LabelledDivider(label: "Video")
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(videoManager.videos, id: \.id) { video in
                    NavigationLink {
                        VideoView(video: video, videoGallery: videoManager.videos)
                    } label: {
                        VideoCard(image: videoManager.videoImage(by: video.url))
                    }
                }
            }
            .padding()
            LabelledDivider(label: "Photo")
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(camera.capturedPhotos, id: \.id) { photo in
                    NavigationLink {
                        PhotoView(photo: photo)
                    } label: {
                        PhotoCard(image: photo)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .onAppear { updateGallery() }
    }

    @ViewBuilder
    private var cameraButton: some View {
        NavigationLink(destination: CameraView().environmentObject(camera)) {
            Text("Go to camera")
        }
        .buttonStyle(CameraButton())
        .padding(.horizontal)
    }

    private func updateGallery() {
        for video in camera.recordedVideoURLs.map({ $0.absoluteString }) {
            if !videoManager.videos.contains(where: { $0.id == video }) {
                videoManager.insertVideo(by: video)
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
