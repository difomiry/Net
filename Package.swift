// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "Net",
  products: [
    .library(
      name: "Net",
      targets: ["Net"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Net",
      dependencies: [],
      path: "Sources"),
    .testTarget(
      name: "NetTests",
      dependencies: ["Net"],
      path: "Tests"),
  ]
)
