//
//  VideoManager.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import AVFoundation
import AVKit
import SwiftUI

final class VideoManager: ObservableObject {
    // MARK: - Dependencies

    @Published private(set) var videos: [Video] = []

    // MARK: - Init

    init() {
        findVideos()
    }

    // MARK: - Actions

    func findVideos() {
        videos.append(Video(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"))
        videos.append(Video(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"))
        videos.append(Video(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"))
    }

    func videoImage(by url: String) -> UIImage? {
        let asset = AVURLAsset(url: URL(fileURLWithPath: url))
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        var cgImage: CGImage?
        do {
            cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        if let image = cgImage {
            let uiImage = UIImage(cgImage: image)
            return uiImage
        }
        return nil
    }

    func insertVideo(by url: String) {
        videos.append(Video(url: url))
    }
}
