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
            PresentationView()
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

## Examples

Refer to this [example project](https://github.com/AdinAck/ExamplePresentation) to see **PresentationKit** in action.