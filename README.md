# TagForm

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]

![](screenshot.gif)

## Table of Contents

- [Installation](#installation)
- [Usage example](#usage-example)
- [Release History](#release-history)
- [Meta](#meta)

## Installation

### Swift Package Manager (Recommended)

#### Package

You can add this package to `Package.swift`, include it in your target dependencies.

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/issetwo/tagform"),
    ],
    targets: [
        .target(
            name: "TagForm",
            dependencies: []),
    ]
)
```

#### Xcode

You can add this package on Xcode.
See [documentation](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

## Usage example

### Empty tag input form
```swift
import SwiftUI
import TagForm

struct ContentView: View {
    @State private var tagInfoList: [TagInfo] = [TagInfo]()
    
    var body: some View {
        TagForm(tagInfoList: $tagInfoList, placeholder: "Input here...", tagColer: .black)
            .padding()
    }
}
```

### Set one or more tags
```swift
import SwiftUI
import TagForm

struct ContentView: View {
    @State private var tagInfoList: [TagInfo] = [.init(label: "Work", color: .red),
                                                .init(label: "School", color: .orange),
                                                .init(label: "Private", color: .yellow)]
    
    var body: some View {
        TagForm(tagInfoList: $tagInfoList, placeholder: "Input here...", tagColer: .black)
            .padding()
    }
}
```

## Release History

* 0.1.0
    * Work in progress

## Meta

Kazuto Yamada – [@issetwo](https://twitter.com/issetwo)

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/issetwo/tagform](https://github.com/issetwo)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
