//
//  TimelineElement.swift
//  
//
//  Created by Adin Ackerman on 7/12/23.
//

import SwiftUI

struct TimelineElement: View {
    let slide: any SlideModel
    
    @Binding var selected: (any SlideModel)?
    
    var isMe: Bool {
        selected?.name == slide.name
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(isMe ? .blue : .green)
            
            Text(slide.name)
                .mask {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: isMe ? 100 : 10 * slide.duration, height: 30)
                }
        }
        .frame(width: isMe ? 100 : 10 * slide.duration, height: 30)
    }
}
