
## Setup

Clone project and then install dependencies using [Cocoapods](https://github.com/CocoaPods/CocoaPods) on the root of the project:

`pod install`

## Features

* Photo list
* Photo Detail Viewer

### Architecture

* Clean + MVVM in presentation layer.
* RxSwift used for dataBinding between ViewController and ViewModel.
* Using Inverse-Reference Coordinator Pattern for screen navigation. [Link](https://medium.com/concretelatinoam%C3%A9rica/inverse-reference-coordinator-pattern-d5a5948c0d90) 
* Modules per feature + a common module called **Core**.
* Networking module for network services without any third-party framework.
* We have interfaces for the interactors and services in order to respect the dependencies rule on the use-cases,
as they should not be aware of some impl that will be in an upper layer than use-cases
* Unit test for main module (PhotoList), networking layer and the PhotoService in order to show how to apply unit test for all other modules.

## Built With

* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)
* [SkeletonView](https://github.com/Juanpe/SkeletonView)

## Acknowledgments

App icons made by FreePick from www.flaticon.com
