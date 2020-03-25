theme: Letters from Sweden, 4
autoscale: true
build-lists: true

# [fit] *What's New in*

# [fit] *Swift* _**5.3**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

---

# [fit] Swift 
# [fit] Evolution

^Swift is growing and evolving, guided by a community-driven process referred to as the "Swift Evolution" process.
Swift Evolution is the process used by the Swift Community to bring new features and changes into the language.

---

# [SE-0269](https://github.com/apple/swift-evolution/blob/master/proposals/0269-implicit-self-explicit-capture.md)
__Increase availability of implicit self in @escaping closures when reference cycles are unlikely to occur__
_No more self. self. self._

[.column]

```swift
// Reference type
class Executor {
  var value: Int = 0
  func doSomething() {
    asyncWork { [self] in
      value = 3 // No need of self.
    }
  }

  func asyncWork(
    completion: @escaping () -> Void) {
    ...
  }
}
```

[.column]

```swift
// Value type
struct ContentView: View {
  @State var taps: Int = 0

  var body: some View {
    Button(action: {
      taps += 1 // No need of self.
    }) {
      Text("Tap me")
    }
  }
}
```

^

---

# [SE-0266](https://github.com/apple/swift-evolution/blob/master/proposals/0266-synthesized-comparable-for-enumerations.md)
__Synthesized Comparable conformance for enum types__
_*No enum types with raw values tho_

[.column]

```swift
enum Outcome: Comparable {
  case low, mid, high
}

let arr: [Outcome] = [
  .mid, .high, .mid, .low
]
arr.sorted() 
// ^ [.low, .mid, .mid, .high]
```

[.column]

```swift
enum Position: Comparable {
  case first(Int), second(Double)
}

let arr: [Position] = [
  .first(2000), .second(0.5), 
  .first(400), .second(1.0)
]

arr.sorted() 
// ^ [
  .first(400), .first(2000), 
  .second(0.5), .second(1.0)
]
```


^

---

# [fit] Swift 
# [fit] Report

---

# [S-]()
__title__
_comment_

```swift

```

^

---

# [fit] & More!
*Function Builders ❤️

---

# [#30045](https://github.com/apple/swift/pull/30045)
__Support if let / if case in function builders.__

```swift
struct ContentView: View {

  var body: some View {
    if let ... {
      ...
    }
    if case let ... {
      ...
    }
  }
}
``` 

---

# [#30174](https://github.com/apple/swift/pull/30174)
__Implement switch support for function builders.__

```swift
struct ContentView: View {

  var body: some View {
    switch ... {
      case ...
      case ...
    }
  }
}
```

---

# [#29419](https://github.com/apple/swift/pull/29419)
__[Function builders] Add support for "if #available"__

```swift
struct ContentView: View {

  var body: some View {
    if #available(OSX 10.51, *) {
      ...
    }
  }
}
```

---

# [#28606](https://github.com/apple/swift/pull/28606)
__[Function builders] Handle #warning and #error__

```swift
struct ContentView: View {

  var body: some View {
    #warning("🤫")
    ...
    #error("💥")
  }
}
```

---

# [#29786](https://github.com/apple/swift/pull/29786)
__Allow initialized let/var declarations in function builders__

```swift
struct ContentView: View {

  var body: some View {
    let a = ...
    ... // no need return
  }
}
```

---

# [fit] Demo time 🤩

---

# [fit] Toolchain 🔗

[swift.org/_download/_](https://swift.org/download/)

- Compiler
- Indexer
- Debugger

^ A tool chain is a set of tools that Xcode needs to build and debug code
^ https://swift.org/download/#snapshots

---

# [fit] Standard Library 
# [fit] Preview Package 📦

[github.com/_apple/swift-standard-library-preview_](https://github.com/apple/swift-standard-library-preview)

- Swift Package
- Doesn't preview 100% of what's new
- Can release apps with it

---

# [fit] Links

Resources:
[_github.com/apple/swift-evolution_](https://github.com/apple/swift-evolution)
[_github.com/apple/swift_](https://github.com/apple/swift)
[_forums.swift.org_](https://forums.swift.org)

Slides Style:
[_jessesquires.com_](http://jessesquires.com) *•* [_@jesse\_squires_](https://twitter.com/jesse_squires)

---

# [fit] *What's New in*

# [fit] *Swift* _**5.3**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)