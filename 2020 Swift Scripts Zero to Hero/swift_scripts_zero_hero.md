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

```shell
$ mkdir Hello
$ cd Hello
$ swift package init --type executable
```

^Note that creating a package from Xcode defaults to creating a library, not an executable.
^A target is considered as an executable if it contains a file named main.swift. The package manager will compile that file into a binary executable.

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

```shell
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

# Build Run Test

[.code-highlight: all]

[.code-highlight: 1]
^This will download, resolve and compile dependencies mentioned in the manifest file Package.swift.

[.code-highlight: 2]
^Since there is only one executable in this package, we can omit the executable name from the swift run command.
^Note that you don't have to build every time before running the script: swift run will also build the script if this hasn't been done

[.code-highlight: 3]
^and here's how to run the tests, note how it seems like at the moment we can specify a specific target, therefore we have to use a `--filter` flag that "Run test cases matching regular expression".

```shell
$ swift build # --target Hello
$ swift run # Hello
$ swift test # --filter HelloTests
```

^Alternatively, you can do all of these also from Xcode, the main difference is that you'll need to make sure to set your mac as a Destination, or you won't be happy.

---

# [FIT] EXAMPLES

---

# Asynchronous Calls

[.code-highlight: all]
^One of the first needs that I had when I got started with scripts was doing things asynchonously.
^In this first example we're fetching something from the internet.
^In an app we just call things like `DispatchQueue.main.async` and we're good, as our app stays alive even when we're not executing anything.
^However in the executable world our script life ends as soon as we reach the end of the file. Unless...

[.code-highlight: 16]
^we run this command here.
^In short what this command does is to tell the current thread to wait for inputs from its loop, making it so that it doesn't terminate immediately.

[.code-highlight: 9, 12]
^However this really means that our script never terminates until we tell it to do so, therefore **always** remember to terminate the script once your asynchronous call has been executed, or it will stay alive forever.
^Linux reserved exit codes: http://www.tldp.org/LDP/abs/html/exitcodes.html
^Note that this is just one of many ways that we can use to keep our script alive, other ways to do so is for example by using [semaphores](https://www.fivestars.blog/code/semaphores.html) or DispatchGroups.

[.code-highlight: all]
^Note how in here we have imported `Foundation`: all the system frameworks are available to us without the need to add them in our `Package.swift` file!

```swift
import Foundation

let url: URL = URL(string: "https://api.github.com/users/zntfdr")!
let request = URLRequest(url: url)
URLSession.shared.dataTask(with: request) { data, _, error in
  if let data = data {
    let responseText = String(data: data, encoding: .utf8)!
    print(responseText)
    exit(EXIT_SUCCESS)
  } else {
    print(error!.localizedDescription)
    exit(EXIT_FAILURE)
  }
}.resume()

RunLoop.current.run()
```

---

# Simple Input

```swift
import Darwin

// We drop the first argument, which is the name of the current script.
let arguments: [String] = Array(CommandLine.arguments.dropFirst())

guard let name: String = arguments.first else { exit(EXIT_FAILURE) }

print("Hello \(name)")
```

```shell
$ swift run Hello World
Hello World
```

---

# Input Parameters (1/3)

```swift
import Basic
import SPMUtility

// We drop the first argument, which is the name of the current script.
let arguments: [String] = Array(CommandLine.arguments.dropFirst())

// Initializes and sets up the `ArgumentParser` instance.
let parser = ArgumentParser(usage: "--name YourName", overview: "Tell me your name!")
let nameArgument: OptionArgument<String> = parser.add(option: "--name", kind: String.self)

do {
  let parseResult: ArgumentParser.Result = try parser.parse(arguments)
  if let name: String = parseResult.get(nameArgument) {
    print("Hello \(name)")
  } else {
    parser.printUsage(on: stdoutStream)
  }
} catch {
  parser.printUsage(on: stdoutStream)
}
```

---

# Input Parameters (2/3)

[.code-highlight: 8-9, 14]

```swift
// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git",
                 from: "0.5.0"),
    ],
    targets: [
        .target(
            name: "Hello",
            dependencies: ["SPMUtility"]),
        .testTarget(
            name: "HelloTests",
            dependencies: ["Hello"]),
    ]
)
```

---

# Input Parameters (3/3)

```shell
$ swift run Hello --name World
Hello World
```

```shell
$ swift run Hello
OVERVIEW: Tell me your name!

USAGE: Hello --name YourName

OPTIONS:
  --help   Display available options
```

---

# Interactive

[.column]

```swift
import Darwin

print("What's your name?")

guard
  let name = readLine(),
  !name.isEmpty else {
    exit(EXIT_FAILURE)
}

print("Hello \(name)")
```

[.column]

```shell
$ swift run Hello
What's your name?
World
Hello World
```

---

# Pipeline Messages

```swift
import Foundation

let stdinData: Data = FileHandle.standardInput.readDataToEndOfFile()
if let stdinString = String(data: stdinData, encoding: .utf8) {
  print(stdinString)
}
```

```shell
$ ls -l | swift run Hello
total 16
-rw-r--r--@ 1 zntfdr  staff  763 Jan 25 22:09 Package.swift
-rw-r--r--  1 zntfdr  staff   39 Jan 24 22:01 README.md
drwxr-xr-x  3 zntfdr  staff   96 Jan 24 22:01 Sources
drwxr-xr-x  4 zntfdr  staff  128 Jan 24 22:01 Tests
```

---

![fill original](images/thats-all-folks.png)

---

# [fit] Links

Resources:
https://github.com/apple/swift-package-manager
https://swift.org/getting-started/#using-the-package-manager
https://rderik.com/blog/command-line-argument-parsing-using-swift-package-manager-s/
