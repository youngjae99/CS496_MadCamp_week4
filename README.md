# CS496_MadCamp_week4
###2020 여름 몰입캠프 4주차 자율과제 : SwiftUI iOS application development

<img src="https://raw.github.com/youngjae99/CS496_MadCamp_week4-Booklip/master/booklip.png" height="400" />

# Booklip

![Swift 5.1](https://img.shields.io/badge/Swift-5.1-FA5B2C) ![Xcode 11](https://img.shields.io/badge/Xcode-11-44B3F6) ![iOS 13.0](https://img.shields.io/badge/iOS-13.0-178DF6) ![iPadOS 13.0](https://img.shields.io/badge/iPadOS-13.0-178DF6) ![MacOS 10.15](https://img.shields.io/badge/MacOS-10.15-178DF6)

Booklip is an application which provides a convenient interface of keeping your favorite verses in a book and decorate them to create a new pretty image.

## How to use
### Step 1
Install Booklip

#### Step 2
Capture your favorite book page

### Step 3
Use `ModalPresenter` and `ModalLink` the same way you would use `NavigationView` and `NavigationLink`:

```swift
struct ContentView: View {
    var body: some View {
        ModalPresenter {
            ModalLink(destination: Text("Modal View")) {
                Text("Main view")
            }
        }
    }
}
```

### Result
![Presenting modal view with SwiftUI](./Docs/Resources/displaying-modal-view.gif)


## Additional information
To add a "close" button to a modal view we can use a `dismiss` closure provided by the `ModalLink`:

```swift
struct ContentView: View {
    var body: some View {
        ModalPresenter {
            ModalLink(destination: { dismiss in
                Button(action: dismiss) {
                    Text("Dismiss")
                }
            }) {
                Text("Main view")
            }
        }
    }
}
