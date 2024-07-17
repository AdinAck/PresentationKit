//
//  TimelineView.swift
//
//
//  Created by Adin Ackerman on 7/12/23.
//

import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var model: Presentation

    let permanent: Bool
    @State private var opacity: CGFloat = 0
    @State private var selected: (any SlideModel)? = nil
    @State private var selectedIndex: Int? = nil

    func fancyScrub(to target: CGFloat) async {
        let delta = Int(target - model.keyframe)

        for _ in 0..<abs(delta) {
            await MainActor.run {
                withAnimation(Presentation.animation) {
                    model.keyframe += CGFloat(delta/abs(delta))
                }
            }

            try? await Task.sleep(for: .seconds(0.2))
        }
    }

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.thinMaterial)
                    .onHover { hovering in
                        withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                            selected = nil
                            selectedIndex = nil
                        }
                    }

                VStack {
                    HStack {
                        Text("Frame: \(Int(model.keyframe))")

                        if let current = model.currentSlide {
                            Text("Local: \(Int(model.keyframe - model.countFrames(to: current)))")
                            Text("Remaining: \(Int(current.duration - model.keyframe + model.countFrames(to: current) - 1))")
                        } else {
                            Text("Local: -")
                            Text("Remaining: -")
                        }

                        Text("Slide: **\(model.currentSlide?.name ?? "-")**")

                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.leading, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        ZStack {
                            HStack(spacing: 10) {
                                ForEach(0..<model.slides.count, id: \.self) { index in
                                    TimelineElement(slide: model.slides[index], selected: $selected)
                                        .onHover { hovering in
                                            withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                                                selected = model.slides[index]
                                                selectedIndex = index
                                            }
                                        }
                                        .onTapGesture {
                                            Task {
                                                await fancyScrub(to: model.countFrames(to: index))
                                            }
                                        }
                                }

                                Spacer()
                            }

                            let slide = model.countSlides(to: model.keyframe) ?? model.slides.count
                            let pos = model.keyframe + CGFloat(slide) + (selectedIndex != nil ? selectedIndex! < slide ? 10 - selected!.duration : 0 : 0 ) + 0.5

                            HStack(spacing: 0) {
                                Spacer()
                                    .frame(width: max(0, pos) * 10 - 1)

                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 2, height: 40)

                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
            }
            .opacity(permanent ? 1 : opacity)
            .onHover { hovering in
                withAnimation {
                    opacity = hovering ? 1 : 0
                }
            }
        }
    }
}
