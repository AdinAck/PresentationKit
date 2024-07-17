//
//  Teleprompter.swift
//
//
//  Created by Adin Ackerman on 7/17/24.
//

import Foundation
import SwiftUI

struct PromptText: View {
    let text: [String]
    let index: Int

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<text.count, id: \.self) { i in
                let current = index == i

                Text(text[i])
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(current ? .primary : .secondary)
            }
        }
    }
}

public struct TeleprompterView: View {
    @EnvironmentObject var model: Presentation

    public init() { }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(model.slides, id: \.name) { slide in
                        if let teleprompt = slide.teleprompt {
                            let local = Int(model.keyframe - model.countFrames(to: slide))
                            PromptText(text: teleprompt, index: local)
                                .offset(x: 0, y: model.keyframe < model.countFrames(to: slide) ? geometry.size.height : local >= Int(slide.duration) ? -geometry.size.height : 0)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .layoutPriority(1)

                TimelineView(permanent: true)
                    .environmentObject(model)
                    .frame(maxWidth: 600)
                    .padding(50)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
