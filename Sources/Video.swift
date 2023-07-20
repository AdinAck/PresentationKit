//
//  Video.swift
//  
//
//  Created by Adin Ackerman on 7/12/23.
//

import Foundation
import SwiftUI
import AVKit

public struct AVPlayerControllerRepresented : NSViewRepresentable {
    var player : AVPlayer
    
    public init(player: AVPlayer) { // so dumb!!!
        self.player = player
    }

    public func makeNSView(context: Context) -> AVPlayerView {
        let view = AVPlayerView()
        view.controlsStyle = .none
        view.player = player
        return view
    }
    
    /// Causes a brief flicker when used
    public func updateNSView(_ nsView: AVPlayerView, context: Context) {
        nsView.player = player
    }
}

public func createLocalUrl(for filename: String, ofType: String) -> URL? {
    let fileManager = FileManager.default
    let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    let url = cacheDirectory.appendingPathComponent("\(filename).\(ofType)")
    
    guard fileManager.fileExists(atPath: url.path) else {
        guard let video = NSDataAsset(name: filename)  else { return nil }
        fileManager.createFile(atPath: url.path, contents: video.data, attributes: nil)
        return url
    }
    
    return url
}
