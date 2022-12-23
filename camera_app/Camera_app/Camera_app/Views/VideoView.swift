//
//  VideoView.swift
//  Camera_app
//
//  Created by Daria Shevchenko on 06.12.2022.
//

import AVFoundation
import AVKit
import SwiftUI

struct VideoView: View {
    // MARK: - Properties

    var video: Video
    var videoGallery: [Video]

    @State private var player = AVQueuePlayer()

    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear { startPlayer() }
    }

    func startPlayer() {
        var items: [AVPlayerItem] = []
        items.append(AVPlayerItem(url: URL(string: video.url)!))
        for elem in videoGallery {
            if elem.id != video.id {
                items.append(AVPlayerItem(url: URL(string: elem.url)!))
            }
        }
        player = AVQueuePlayer(items: items)
        player.volume = 1.0
        player.play()
    }
}
