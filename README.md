# WrappingHStack

WrappingHStack is an nmplementation of SwiftUI `Layout` that works similar to HStack but moves elements to the next line automatically when they don't fit the current row.

<img src="https://github.com/luquanlang/wrapping-hstack/assets/45352151/711ee303-4874-4b1b-80b8-e6620efd845d" width="350"/>

## Basic Usage

Just declare it in your view and add the desired elements within it.

```swift
var body: some View {
	VStack {
		Text("WrappingHStack")
			.font(.title)
			.padding(.bottom)
		WrappingHStack {
			ForEach(arrayOfFruits, id: \.self) { fruit in
				Button(fruit) {
					// Any action
				}
				.buttonStyle(.bordered)
				.padding(.bottom, 8)
			}
		}
	}
	.padding()
}
```
## Installation

You can add this library to your project by adding it as an Xcode package dependency.
1. Go to File > Add Package...
2. Paste "https://github.com/luquanlang/wrapping-hstack.git" 

If you need to access this library from another package, add it as a dependency in its `Package.swift` file.

```swift
dependencies: [
	.package(url: "https://github.com/luquanlang/wrapping-hstack.git", from: "1.0.0"),
]
```

## License
This library is released under the MIT license. See [LICENSE](LICENSE) for details.
