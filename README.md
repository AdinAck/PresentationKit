# PresentationKit

Create stunning presentations with the power of SwiftUI.

[Demo](https://github.com/AdinAck/PresentationKit/assets/30732255/ac7526dc-9204-4dd9-9f7f-cb0405cd4cfe)

## Installation

**XCode Package Manager**

Add this repo to your SwiftUI project via the package manager.

```
https://github.com/AdinAck/PresentationKit
```

## Usage

**MyApp.swift**

```swift
import SwiftUI
import PresentationKit

@main
struct MyApp: App {
    @StateObject var model = Presentation(bgColor: .white, slides: [
        Title(),
        // put more slides here
    ])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
        .commands {
            CommandMenu("Control") {
                Text("Current frame: \(Int(model.keyframe))")
                
                Button("Next Keyframe") {
                    model.nextKeyframe()
                }
                .keyboardShortcut("N")
                
                Button("Previous Keyframe") {
                    model.prevKeyFrame()
                }
                .keyboardShortcut("B")
            }
        }
    }
}
```

**ContentView.swift**

Here is an example `ContentView` but it is also possible to not make a `ContentView` and simply place the `PresentationView` directly in the `WindowGroup`.

```swift
import SwiftUI
import PresentationKit

struct ContentView: View {
    @EnvironmentObject var model: Presentation
    
    var body: some View {
        PresentationView()
            .environmentObject(model)
    }
}
```

**Title.swift**

Here is an example of a title slide,

```swift
import Foundation
import SwiftUI
import PresentationKit

class Title: SlideModel {
    let name: String = "Title"
    let duration: CGFloat = 2
    
    func view(t: CGFloat, scale: CGFloat) -> AnyView {
        AnyView(
            TitleView(t: t, scale: scale)
                .environmentObject(self)
        )
    }
}

struct TitleView: SlideView {
    @EnvironmentObject var model: Title
    
    var t: CGFloat
    var scale: CGFloat
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(alignment: .leading) {
                Text("PresentationKit")
                    .font(.system(size: 600 * scale))
                    .fontWeight(.bold)
                    .foregroundColor(.init(red: 3/255, green: 130/255, blue: 133/255))
                    .offset(y: t >= 1 ? 0 : 100 * scale)
                    .opacity(t >= 1 ? 1 : 0)
                    .animation(Presentation.animation, value: t)
                
                Text("Stunning presentations")
                    .font(.system(size: 150 * scale))
                    .fontWeight(.medium)
                    .foregroundColor(.init(red: 230/255, green: 126/255, blue: 34/255))
                    .offset(y: t >= 1 ? 0 : 100 * scale)
                    .opacity(t >= 1 ? 1 : 0)
                    .animation(Presentation.animation.delay(0.1), value: t)
                
                Text("Adin Ackerman")
                    .font(.system(size: 100 * scale))
                    .fontWeight(.thin)
                    .italic()
                    .foregroundColor(.black)
                    .offset(y: t >= 1 ? 0 : 100 * scale)
                    .opacity(t >= 1 ? 1 : 0)
                    .animation(Presentation.animation.delay(0.2), value: t)
            }
        }
    }
}
```