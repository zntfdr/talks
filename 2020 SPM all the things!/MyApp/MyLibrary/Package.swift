// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "MyLibrary",
  defaultLocalization: LanguageTag("en"),
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "MyLibrary", targets: ["MyLibrary"]),
  ],
  dependencies: [],
  targets: [
    .target(name: "MyLibrary", dependencies: []),
    .testTarget(name: "MyLibraryTests", dependencies: ["MyLibrary"]),
  ]
)
