theme: Letters from Sweden, 1
autoscale: true
build-lists: true

# [fit] *What's New in*

# [fit] *Swift* _**5.2**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

---

# [fit] Xcode _**11.4**_ 🎉

[.column]

- iOS/macOS/tvOS/watchOS universal apps 🚀
- View debugger enhancements 👀
- Xcode Previews canvas enhancements 🖼


[.column]

- simctl improvements 🖥
- Xcode Simulators enhancements 📲
- All the Swift 5.2 goodies 🏎
- XCTest improvements 🤖

^ Today I'm not going to cover all the points but I'm going to cover just one, which is..
^ https://developer.apple.com/documentation/xcode_release_notes/xcode_11_4_beta_release_notes

---

# [fit] All the Swift _**5.2**_ goodies 

# [fit] 🏎

^ A piece of trivia for you in case you didn't notice already: 
the swift logo is in the racing car emoji. 
And the word swift is marked in the wheels. 
It's been there since iOS 10!

---

# [fit] Swift 
# [fit] Evolution

^Swift is always growing and moving forward:
Swift Evolution is the process used by the Swift Community to bring new features and changes into the language.

---

# [SE-0253](https://github.com/apple/swift-evolution/blob/master/proposals/0253-callable.md)
__Callable values of user-defined nominal types__
_Call functions directly from the instance name_

```swift
struct Incrementer {
    var value: Int

    //                 ↓ new in Swift 5.2
    mutating func callAsFunction(add number: Int) {
        value += number
    }
}

var inc = Incrementer(value: 5)
inc(add: 1) // inc.value = 6
inc(add: 4) // inc.value = 10
```

^Slide template intro!

^This change introduces new special functions called `callAsFunction`: 
what's special about them is that, on the call site, we can skip the function name and directly pass the parameters on the instance name.

^we can now apply the call syntax directly on the instance name, without having to explicitly call a declared function.

^Callable values are values that define function-like behavior and can be called using function call syntax.

^Instances of Types that expose one or more `callAsFunction` methods are named Callable values.

^call by skipping the function name and call it directly on the instance name.

^func callAsFunction argument labels are required at call sites.
Multiple func callAsFunction methods on a single type are supported.
mutating func callAsFunction is supported.
func callAsFunction works with throws and rethrows.
func callAsFunction works with trailing closures.

---

# [SE-0249](https://github.com/apple/swift-evolution/blob/master/proposals/0249-key-path-literal-function-expressions.md)
__Key Path Expressions as Functions__
_Even more uses of keypaths!_

```swift
struct User {
    let email: String
    let isAdmin: Bool
}

let users: [User] = [...]

//                                  ↓ new in Swift 5.2
let allEmails: [String] = users.map(\.email)
let adminsOnly: [User] = users.filter(\.isAdmin)
```

^Wherever Swift allows `(Root) -> Value` functions, it now allows `\Root.value` key path expressions.

---

# [fit] Swift 
# [fit] Report

^ Beside the Swift Evolution process, Swift also has another process called Swift Report, you can think about is as your Jira or ticket management you use.
In here the Swift community discusses about unexpected, inconsistend behaviour and more.

---

# [SR-6118](https://bugs.swift.org/browse/SR-6118)
__mechanism to hand through #file/#line in subscripts__
_Subscripts default arguments!_

```swift
struct Subscriptable {
  //                       ↓ new in Swift 5.2
  subscript(x: Int, y: Int = 0) -> Int { 
    ...
  }
}

let s = Subscriptable()
print(s[2])
```

---

# [SR-4206](https://bugs.swift.org/browse/SR-4206)
__Override checking does not properly enforce requirements__
_No more generic restrictions in overrides_

```swift
protocol P {}

class Base {
  func foo<T>(arg: T) {}
}

class Derived: Base {
  //                   ↓ error in Swift 5.2
  override func foo<T: P>(arg: T) {}
}
```

^A method override is no longer allowed to have a generic signature with requirements not imposed by the base method.

---

# [SR-11429](https://bugs.swift.org/browse/SR-11429)
__Don't look through CoerceExprs in markDirectCallee__
_`as` operator can now be used to disambiguate a call to a function with argument labels._

```swift
func foo(x: Int) {}
func foo(x: UInt) {}

(foo as (Int) -> Void)(5)  // Calls foo(x: Int)
(foo as (UInt) -> Void)(5) // Calls foo(x: UInt)

// Swift <5.2: Error: Ambiguous reference to member 'foo(x:)'
```

^The compiler will now correctly strip argument labels from function references used with the as operator in a function call.
Previously this was only possible for functions without argument labels.

---

# [SR-2189](https://bugs.swift.org/browse/SR-2189)
__Nested function with local default value crashes__
_local functions default arguments can capture outer scope values_

```swift
func outer(x: Int) -> (Int, Int) {
  var x = 5
  //                  ↓ works in Swift 5.2
  func inner(y: Int = x) -> Int {
    return y
  }

  return (inner(), inner(y: 0))
}
```

^Previously this would crash the compiler.

---

# [SR-2790](https://bugs.swift.org/browse/SR-2790)
__Reject UnsafePointer initialization via implicit pointer conversion__
_Safer temporary pointers management with new warnings_

```swift
struct S {
  var ptr: UnsafePointer<Int8>
}

func foo() {
  var i: Int8 = 0
  let ptr = UnsafePointer(&i) // dangling pointer
  
  let s1 = S(ptr: [1, 2, 3]) // argument should be a pointer that outlives the call
  
  let s2 = S(ptr: "hello") // argument should be a pointer that outlives the call
}
```

^ You might have already heard that one effort of Swift 5.2 and later is in the diagnostics, this is very obvious while writing SwiftUI but that's not all, this swift report is an example of that.

^ An `UnsafePointer` instance is a pointer to memory, the pointer is just a pointer, it has no role in whatever it's pointing memory management, which means that it can be deallocated at any point without prior notice.

^ When this happens, we have a dangling pointer, which is a pointer to dead memory.

^ // warning: initialization of 'UnsafePointer<Int8>' results in a dangling pointer
^ // warning: passing '[Int8]' to parameter, but argument 'ptr' should be a pointer that outlives the call to 'init(ptr:)'
^ // warning: passing 'String' to parameter, but argument 'ptr' should be a pointer that outlives the call to 'init(ptr:)'

^All 3 of the above examples are unsound because each argument produces a temporary pointer only valid for the duration of the call they are passed to. Therefore the returned value in each case references a dangling pointer.
^ Previously this was going to compile without any warnings around the dangling pointer.

---

# [SR-11841](https://bugs.swift.org/browse/SR-11841)
__Lazy filter runs in unexpected order__
_Lazy filters now run the other (right) way_

```swift
let evens = (1...10).lazy
    .filter { $0.isMultiple(of: 2) }
    .filter { print($0); return true }
_ = evens.count

// Swift <5.2: Prints 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 on separate lines
// Swift 5.2: Prints 2, 4, 6, 8, 10 on separate lines
```

^When chaining calls to `filter(_:)` on a lazy sequence or collection, the filtering predicates will now be called in the same order as eager filters.
^ Previously, the predicates were called in reverse order.

^When lazy is not used, filter processes the entire array and stores the results into a new array.
^When lazy is used, the values in the sequence or collection are produced on demand from the downstream functions

---

# [fit] Links

Slides:
[github.com/_zntfdr/talks_](https://github.com/zntfdr/talks/)

Resources:
[github.com/_apple/swift-evolution_](https://github.com/apple/swift-evolution)
[github.com/_apple/swift_](https://github.com/apple/swift)
[_forums_.swift.org](https://forums.swift.org)

Slides Style:
[jessesquires.com](http://jessesquires.com) *•* [_@jesse\_squires_](https://twitter.com/jesse_squires)

---

# [fit] *What's New in*

# [fit] *Swift* _**5.2**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)
