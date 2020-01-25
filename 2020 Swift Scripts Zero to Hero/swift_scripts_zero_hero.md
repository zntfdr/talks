theme: Ostrich
autoscale: true
build-lists: true

# [fit] Swift Scripts:

# [fit] Zero to Hero 🦸🏼‍♀️

## <br>

## __*Federico Zanetello*__

★★★★★ [**fivestars.blog**](http://fivestars.blog) *•* [**@zntfdr**](http://twitter.com/zntfdr)

---

# [fit] 🙋🏻‍♀️🙋🏼‍♀️🙋🏽‍♀️🙋🏾‍♀️🙋🏿‍♀️

# [fit] 🙋🏻‍♂️🙋🏼‍♂️🙋🏽‍♂️🙋🏾‍♂️🙋🏿‍♂️

^Before starting, I would like to ask: 
- raise your hand if you've ever written a script to automate anything on your mac.
- raise your hand if you've ever written a script in Swift.
- raise your hand if you've ever written a Swift script as an executable package.

---

# [fit] WHY? 🤔

^The main reasons for an iOS developer to write a swift script is familiarity: writing a script is very similar to write an app or a library. 
In fact we're going to build a script using SPM.

^Furthermore, if we're already writing in Swift, having to change to ruby, bash, python etc requires us to make a context switch, this might seem reasonable, however making this context switch everytime is not easy.

^And since we're all working in teams with multiple developers, just because one developer is fluent in python, this doesn't mean that other people in the team might be able to understand and/or even update the script if needed in the future. Using Swift is a safe bet.

---

# Getting Started

```
$ mkdir Hello
$ cd Hello
$ swift package init --type executable
```

---

# The Package Structure

[.code-highlight: all]
^Once we execute the last command a bunch of files are created in the current directory, this is the complete structure.

[.code-highlight: 7-11]
^The `Tests` folder is where we will add our tests.

[.code-highlight: 4-6]
^The `Sources` folder is where our script code will be.

[.code-highlight: 1]
^The `.gitignore` is prefilled with directories that we should ignore when saving things on our repositories.

[.code-highlight: 3]
^The `README.md` is there for us to describe the package.

[.code-highlight: 2]
^Lastly, we have the most important file, the `Package.swift` declaration. Let's look at that.

```
├── .gitignore
├── Package.swift
├── README.md
├── Sources
│   └── Hello
│       └── main.swift
└── Tests
    ├── HelloTests
    │   ├── HelloTests.swift
    │   └── XCTestManifests.swift
    └── LinuxMain.swift
```

---

# Package.swift

[.code-highlight: all]
^First of all, you can double click on this file to open the whole package in Xcode.
^The `Package.swift` is the manifest of our package, regardless of whether it's an executable, a library, a mix of those, or else.

^The Package type is used to configure the name, products, targets, dependencies and various other parts of the package.
^Even if it's a swift file, traditionally the properties of a Package are defined in the initializer statement, and not modified after initialization.

[.code-highlight: 1]
^The Swift tools version declares the version of the `PackageDescription` library, the minimum version of the Swift tools and Swift language compatibility version to process the manifest, and the minimum version of the Swift tools that are needed to use the Swift package. 
^Each version of Swift can introduce updates to the PackageDescription library, but the previous API version will continue to be available to packages which declare a prior tools version. This behavior lets you take advantage of new releases of Swift, the Swift tools, and the PackageDescription library, without having to update your package's manifest or losing access to existing packages.
^Even if this appears as a comment, this declaration is required as it states how to interpret the package:
^it's similar to how we have a `SWIFT_VERSION` key in our `XCBuildConfiguration` in our Xcode `.xcodeproj`.

[.code-highlight: 3]
^Then we have an import statement: The `PackageDescription` defines which APIs are available to the `Package.swift` file.

[.code-highlight: 5,17]
^Then we start with the actual package definition.

[.code-highlight: 6]
^We have the package name.

[.code-highlight: 7-8]
^Its dependencies.
^A package dependency typically consists of a Git URL to the source of the package, and a requirement for the version of the package. We will see an example later on.
^Dependencies declare other packages that this package depends on.
^`.package(url: /* package url */, from: "1.0.0"),`

[.code-highlight: 9, 16]
^The package targets: A target is the basic building block of a Swift package.
^Each target contains a set of source files that are compiled into a module or test suite.
^A target may depend on other targets within the same package and on products vended by the package's dependencies.

[.code-highlight: 10-12]
^For example here we have our main target, that currenly has no dependencies and has name `toolName`.

[.code-highlight: 13-15]
^Then we have a second, separate target for tests. This target depends on the package that we want to test.

^The difference between `.target`s and `.testTarget`s is that `.testTarget`s are not expected to have any headers. (you can see this by taking a look at `.testTarget` initializer that is missing the `publicHeadersPath` parameter, thet's the only difference as of now.

```swift
// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
    ],
    targets: [
        .target(
            name: "Hello",
            dependencies: []),
        .testTarget(
            name: "HelloTests",
            dependencies: ["Hello"]),
    ]
)
```

---

# main.swift

```swift
print("Hello, world!")
```

---

![fill original](images/thats-all-folks.png)

---

# [fit] Links

Resources:
https://github.com/apple/swift-package-manager
https://swift.org/getting-started/#using-the-package-manager
