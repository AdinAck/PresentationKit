//
//  Presentation.swift
//  
//
//  Created by Adin Ackerman on 7/12/23.
//

import Foundation
import SwiftUI

public class Presentation: ObservableObject {
    @Published public var keyframe: CGFloat = 0
    
    public static let animation: Animation = Animation.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)
    
    let bgColor: Color
    let slides: [any SlideModel]
    
    var currentSlide: (any SlideModel)? {
        if let index = countSlides(to: keyframe) {
            return slides[index]
        }
        
        return nil
    }
    
    public init(bgColor: Color, slides: [any SlideModel]) {
        self.bgColor = bgColor
        self.slides = slides
    }
    
    public func nextKeyframe() {
        withAnimation(Self.animation) {
            keyframe += 1
        }
    }
    
    public func prevKeyFrame() {
        withAnimation(Self.animation) {
            if keyframe > 0 {
                keyframe -= 1
            }
        }
    }
    
    func countFrames(to slide: any SlideModel) -> CGFloat {
        let index = slides.firstIndex { _slide in
            _slide.name == slide.name
        }
        
        guard let index else { return 0 }
        
        return slides[..<index].map({ frame in frame.duration }).reduce(0, { partialResult, length in partialResult + length })
    }
    
    func countFrames(to slideIndex: Int) -> CGFloat {
        return slides[..<slideIndex].map({ frame in frame.duration }).reduce(0, { partialResult, length in partialResult + length })
    }
    
    func countSlides(to frame: CGFloat) -> Int? {
        var frameTotal = 0.0
        
        for (i, slide) in slides.enumerated() {
            frameTotal += slide.duration
            
            if frameTotal > frame {
                return i
            }
        }
        
        return nil
    }
}

public struct PresentationView: View {
    @EnvironmentObject var model: Presentation
    
    public init() { } // so dumb
    
    public var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    self.model.bgColor
                    
                    let t = model.keyframe
                    let scale = min(CGFloat(geometry.size.width) / 3840, CGFloat(geometry.size.height) / 2160)
                    
                    ForEach(0..<model.slides.count, id: \.self) { index in
                        let local_t = t - model.countFrames(to: index)
                        let duration = model.slides[index].duration
                        
                        if local_t >= -1 && local_t <= duration {
                            model.slides[index].view(t: local_t, scale: scale)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .opacity((0..<duration).contains(local_t) ? 1 : 0)
                                .animation(Presentation.animation, value: t)
                        }
                    }
                }
            }
            
            TimelineView()
                .environmentObject(model)
        }
    }
}