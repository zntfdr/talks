theme: Ostrich
autoscale: true
build-lists: true

# [fit] Swift Scripts:

# [fit] Zero to Hero 🦸🏼‍♀️

## <br>

## __*Federico Zanetello*__

★★★★★ [**fivestars.blog**][fivestarsblog] *•* [**@zntfdr**][twitterHandle]

^Hi! My name is .. and I'm iOS Developer living and working here in 🇹🇭, in here it's ... which is well past my usual bed time, however today I'm very very pleased to be with all of you for this awesome conference.

^My presentation topic is Swift scripting, and you might be wondering, we're iOS Developers at UIKonf, ...

---

# [fit] WHY? 🤔

^..why should we care about Swift scripting?
^As developers we use tons of scripts everyday: fastlane, swiftlint, XcodeGen, sourcery you name it.
^Those are great, however our need for automation doesn't end there, there are always plenty of opportunities to make our projects and our flows even better. That's why Swift scripting is important.

^Why Swift? The main reason is familiarity: 

^.. for you, as writing a script is very similar to write an app or a library. 
^.. for your team, even if you're familiar with  etc, if tou're adding a script in your team project, canchges are everybody knows Swift, while you might be the only one familar with python or other.

---

# [fit] Getting 
# [fit] Started

^Time to get started!

---

```shell
hello
```

^Today we're going to build a script called hello. 
^Its main function is to greet you. 
^I know it sounds simple, however we will see many ways to do.

---

# Creating an executable

```shell
$ mkdir hello
$ cd hello
$ swift package init --type executable
```

^Note that creating a package from Xcode defaults to creating a library, not an executable.
^A target is considered as an executable if it contains a file named main.swift. The package manager will compile that file into a binary executable.

---

# The Package Structure

[.code-highlight: all]
^Once we execute the last command a bunch of files are created in the current directory, this is the complete structure.
I'm going to highlight the main components here.

[.code-highlight: 7-11]
^The `Tests` folder contains our test targets.

[.code-highlight: 4-6]
^The `Sources` folder contains our real targets. 

[.code-highlight: 5, 8]
^Each target representation is a folder:
all files within that folder belongs to that specific target, and every file can access to all other declarations within that folder.
^As you can see we have one target, hello, in our sources folder and one target, helloTests, in the test folders.

[.code-highlight: 2]
^Lastly, we have the most important file, the `Package.swift` declaration. Let's look at that.

```shell
├── .gitignore
├── Package.swift
├── README.md
├── Sources
│   └── hello
│       └── main.swift
└── Tests
    ├── helloTests
    │   ├── helloTests.swift
    │   └── XCTestManifests.swift
    └── LinuxMain.swift
```

---

# Package.swift

[.code-highlight: all]
^The file is the manifest of our package.

^The Package type declares the whole package declaration.
^If something is not declared here, it doesn't exist. 

[.code-highlight: 6]
^we have the name

[.code-highlight: 7-8]
^Its dependencies.

[.code-highlight: 9, 16]
^The package targets: A target is the basic building block of a Swift package.
^Each target contains a set of source files that are compiled into a module or test suite.
^A target may depend on other targets within the same package and on products vended by the package's dependencies.

[.code-highlight: 10-12]
^For example here we have our main target, that currently has no dependencies and has name `toolName`.

[.code-highlight: 13-15]
^Then we have a second, separate target for tests. This target depends on the package that we want to test.

```swift
// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "hello",
    dependencies: [
    ],
    targets: [
        .target(
            name: "hello",
            dependencies: []),
        .testTarget(
            name: "helloTests",
            dependencies: ["hello"]),
    ]
)
```

---

# The Package Structure

[.code-highlight: 6]
^Lastly, we have the most important file, the `Package.swift` declaration. Let's look at that.

```shell
├── .gitignore
├── Package.swift
├── README.md
├── Sources
│   └── hello
│       └── main.swift
└── Tests
    ├── helloTests
    │   ├── helloTests.swift
    │   └── XCTestManifests.swift
    └── LinuxMain.swift
```

---

# main.swift

```swift
print("Hello, world!")
```

---

# Build Run Test

[.code-highlight: all]
^build: download, resolve and compile dependencies
^run: will build if needed

```shell
$ swift build hello
$ swift run hello
$ swift test
```

---

### ..or use Xcode

---

# [fit] We're done! 
# 🙌🏻

^if you've been following until now, congratulations! You now know exactly how to build and run your scripts!
^I'm not going to show you how to write scripts, because that's like saying I'm going to teach you to develop an app:
you already know how to code apps, therefore you know how to code scripts.

---

^ Well...

### *Almost

---

# [fit] GUI -> TUI

^The truth is..
^scripts are apps without a GUI, a Graphical User Interface, but with a TUI, Text User Interface.

^Which means that the way we interact with them is different, the way the data flows is different, so I hope you're ready because from now on is all code!

---

# Launch Arguments

[.column]

[.code-highlight: all]

[.code-highlight: 6]
^First we have the CommandLine, which is an object that gives us access to the arguments of the current process.

^If you do UI Testing in your apps, this is kind of what we're doing when we pass launch arguments with XCUIApplication.

[.code-highlight: 3-7]
^The first argument is always the script execution path: 
if we are reading the input sent along with the script, we want to get rid of this path and read only what's after that.

[.code-highlight: 10]
^Then we have the exit command, which terminates the current process with either a successful state or a failure.

[.code-highlight: all]
^Now that we have seen how it works, we can see the big picture..

```swift
import Foundation

let arguments: [String] = Array(
  // We drop the first argument, 
  // which is the script execution path.
  CommandLine.arguments.dropFirst()
)

guard let name = arguments.first else { 
  exit(EXIT_FAILURE) 
}

print("Hello \(name)")
```

[.column]

```shell
$ swift run hello Federico
> Hello Federico
```

---

# Interactive

[.column]

[.code-highlight: all]

[.code-highlight: 6]
^gets a string from standard, which means that waits until a return key is hit.
^synchronous.

[.code-highlight: all]

```swift
import Foundation

print("What's your name?")

guard
  let name = readLine(),
  !name.isEmpty else {
    exit(EXIT_FAILURE)
}

print("Hello \(name)")
```

[.column]

```
$ swift run hello
> What's your name?
> Federico
> Hello Federico
```

---

# Environment Variables

^CI

[.column]

[.code-highlight: all]

[.code-highlight: 3, 4]
^ProcessInfo is a collection of information of the current process, and among this information we get to access to the process environment dictionary

[.code-highlight: all]

```swift
import Foundation

let processInfo = ProcessInfo.processInfo
let environment = processInfo.environment

if let name = environment["MYNAME"] {
  print("Hello \(name)")
} else {
  exit(EXIT_FAILURE)
}
```

[.column]

```
$ MYNAME=Federico swift run
> Hello Federico
```

---

# Pipeline Messages

^Another important aspect of scripting

[.column]

[.code-highlight: all]

[.code-highlight: 3, 6]
^handles data access for files, sockets, pipes, and more.
^In our case we use it to get the `standardInput` terminal, and then read the available data at launch.

[.code-highlight: all]

```swift
import Foundation

let standardInput: FileHandle = .standardInput

if let inputString = String(
  data: standardInput.availableData,
  encoding: .utf8
) {
  print("Hello \(inputString)")
} else {
  exit(EXIT_FAILURE)
}
```

[.column]

```shell
$ echo Federico | swift run hello
> Hello Federico
```

---

<!--

# Asynchronous Work

[.code-highlight: all]
^In an app we just call things like `DispatchQueue.main.async` and we're good, as our app stays alive even when we're not executing anything.
^However in the executable world our script life ends as soon as we reach the end of the file. Unless...

[.code-highlight: 9]
^we run this command here.
^In short we're telling the current loop to wait for more inputs, stopping it from terminate immediately.

[.code-highlight: 6]

```swift
import Foundation

DispatchQueue.global(qos: .default).async {
  // long task here...
  print("✅ done!")
  exit(EXIT_SUCCESS)
}

RunLoop.current.run()
```

---
-->

# [fit] Argument
# [fit] Parser

---

# Adding a Dependency

[.code-highlight: 4-5, 11-12]

```swift
let package = Package(
    name: "hello",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git",
                 from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "hello",
            dependencies: [
                .product(name: "ArgumentParser", 
                         package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "helloTests",
            dependencies: ["hello"]),
    ]
)
```

---

# ArgumentParser

[.column]

[.code-highlight: all]

[.code-highlight: 4-5]
^Property wrappers

[.code-highlight: 7-9]

[.code-highlight: all]

```swift
import ArgumentParser

struct Hello: ParsableCommand {
  @Argument(help: "Specify your name.")
  var name: String

  func run() throws {
    print("Hello \(name)")
  }
}

Hello.main()
```

[.column]

```shell
$ swift run hello Federico
> Hello Federico

$ swift run hello
> Error: Missing expected argument '<name>'
> Usage: hello <name>

$ swift run hello --help
> USAGE: hello <name>
>
> OPTIONS:
>   <name>         Specify your name.
>   -h, --help     Show help information.
```

---

SwiftToolsSupport's
# [fit] TSCUtility 
# [fit] & TSCBasic

^Previously known as SPMUtility & Basic
^Tools-Support-Core
^They offer an abstractions for common operations.
^Eventually TSCUtility functions will migrate to TSCBasic.
^These libraries come under an umbrella called SwiftToolsSupport.

---

# Adding a Dependency 2

[.code-highlight: 4-5, 11-12]

```swift
let package = Package(
    name: "hello",
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core.git",
                 from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "hello",
            dependencies: [
                .product(name: "SwiftToolsSupport", 
                         package: "swift-tools-support-core")
            ]
        ),
        .testTarget(
            name: "helloTests",
            dependencies: ["hello"]),
    ]
)
```

---

# Progress State

^leaving terminal completely blocked bad UX

[.code-highlight: all]

[.code-highlight: 5-7]
^In here we define this animation, again this is not the only one that we have.

[.code-highlight: 12-14]
^In here we update it. Note how we don't need to worry about the presentation at all, in here we just tell at which step we're currently out of how many, and that's all, `TSCUtility` will take care of the rest for us.

[.code-highlight: 16]
^Lastly, we call animation complete when the work is done.

[.code-highlight: all]

[.column]

```swift
import Foundation
import TSCBasic
import TSCUtility

let animation = PercentProgressAnimation(
  stream: stdoutStream,
  header: "Loading Greeting")

for i in 0..<100 {
  let second: Double = 1_000_000
  usleep(UInt32(second * 0.05))
  animation.update(step: i,
                   total: 100,
                   text: "Almost there...")
}

print("Hello UIKonf!")
```

[.column]

![autoplay loop 80%](videos/PercentProgressAnimation.mov)

---

<!--

# Colors

[.column]

[.code-highlight: all]
^And of course we need colors to make our script pretty.
^The way to do so takes a few steps more than just a standard print, however you please feel free to create your own wrapper around it if you'd like to.
^Here's how to do it:

[.code-highlight: 3-5]
^First of all, we need to create a `TerminalController`, this, as the name says, controls the terminal. It allows operations like cursor movement and colored text output on.

[.code-highlight: 7-10]
^The colors that `TSCBasic` offer us are limited, I suspect these are the standard colors for all scripts, but I might be wrong. 

[.code-highlight: 13-17]
^Lastly, here's how we print our message in the command line, note how we can also specify the font weight.
^When we write to the terminal we're just writing to it, it doesn't end the line, so we must do so ourselves by calling `endLine()`.

[.code-highlight: all]

```swift
import TSCBasic

let terminalController = TerminalController(
  stream: stdoutStream
)

let colors: [TerminalController.Color] = [
  .noColor, .red, .green, .yellow, 
  .cyan, .white, .black, .grey
]

for color in colors {
  terminalController?.write("Hello World", 
                            inColor: color, 
                            bold: true)
  terminalController?.endLine()
}
```

[.column]

![inline original](images/colors.png)

---

-->

# [fit] Release 

---

# Use the script anywhere

^-c flag is the configuration flag, which defaults to debug, however in this case we're setting it to release.
^once run we can find the executable under the folder `.build/release`, and copy it to the user binary folder and then we can run our command from everywhre

```shell
$ swift build -c release
$ cp .build/release/hello /usr/local/bin/hello

$ hello
```

<!--
---

# [fit] Evolution

---

![50%](images/macBook-air.png)

-->
---

# [fit] Links

[fivestars.blog/**ultimate-guide-swift-executables.html**](https://www.fivestars.blog/code/ultimate-guide-swift-executables.html)
[github.com/**apple/swift-package-manager**](https://github.com/apple/swift-package-manager)
[github.com/**apple/swift-argument-parser**](https://github.com/apple/swift-argument-parser)
[github.com/**apple/swift-tools-support-core**](https://github.com/apple/swift-tools-support-core/)
[github.com/**zntfdr/talks**](https://github.com/zntfdr/talks/)

---

# [fit] Swift Scripts:

# [fit] Zero to Hero 🦸🏼‍♀️

## <br>

## __*Federico Zanetello*__

★★★★★ [**fivestars.blog**][fivestarsblog] *•* [**@zntfdr**][twitterHandle]

[fivestarsblog]: http://fivestars.blog/
[twitterHandle]: http://twitter.com/zntfdr