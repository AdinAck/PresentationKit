# PresentationKit

Create stunning presentations with the power of SwiftUI.

![Demo](https://github.com/AdinAck/PresentationKit/assets/30732255/41e289b5-35f6-4d39-9abe-659fa00c77e4)

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
