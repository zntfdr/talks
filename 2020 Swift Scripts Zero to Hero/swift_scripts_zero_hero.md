theme: Ostrich
autoscale: true
build-lists: true

# [fit] Swift Scripts:

# [fit] Zero to HERO

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
$ mkdir toolName
$ cd toolName
$ swift package init --type executable
```

---

# Our Package

```
Tests/
Sources/
.gitignore
Package.swift
README.md
```

^Once we execute the last command a bunch of files are created in the current directory.
^The `.gitignore` is prefilled with directories that we should ignore when saving things on our repositories.
^The `README.md` is there for us to describe the package.
^The `Sources` folder is where our script code will be.
^The `Tests` folder is where we will add our tests.

---

```swift
// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "toolName",
    dependencies: [
    ],
    targets: [
        .target(
            name: "toolName",
            dependencies: []),
        .testTarget(
            name: "toolNameTests",
            dependencies: ["toolName"]),
    ]
)
```

^The swift-tools-version declares the minimum version of Swift required to build this package.
^Dependencies declare other packages that this package depends on.
^.package(url: /* package url */, from: "1.0.0"),
^Targets are the basic building blocks of a package. A target can define a module or a test suite.
^Targets can depend on other targets in this package, and on products in packages which this package depends on.

---

# [fit] Links

Resources:
