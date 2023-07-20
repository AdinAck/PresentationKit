//
//  Slide.swift
//  
//
//  Created by Adin Ackerman on 7/12/23.
//

import Foundation
import SwiftUI

public protocol SlideModel: ObservableObject {
    var name: String { get }
    var duration: CGFloat { get }
    var transition: Transition { get }
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView
}

public protocol SlideView: View {
    var t: CGFloat { get set }
    var scale: CGFloat { get set }
}
