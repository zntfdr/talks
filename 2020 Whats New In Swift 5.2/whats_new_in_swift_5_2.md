theme: Letters from Sweden, 1
autoscale: true
build-lists: true

# [fit] *What's New in*

# [fit] *Swift* _**5.2**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

---

# [fit] Xcode 11.4 🎉

[.column]

- iOS/macOS/tvOS/watchOS universal apps 🚀
- View debugger enhancements 👀
- Xcode Previews canvas enhancements 🖼


[.column]

- simctl improvements 🖥
- Xcode Simulators enhancements 📲
- All the Swift 5.2 goodies 🏎
- XCTest improvements 🤖

^ https://developer.apple.com/documentation/xcode_release_notes/xcode_11_4_beta_release_notes

---

# [fit] Swift 
# [fit] Evolution

^Swift is always growing and evolving:
Swift Evolution is the process used by the Swift Community to bring new features and changes into the language.

---

# [SE-0253](https://github.com/apple/swift-evolution/blob/master/proposals/0253-callable.md)
__Callable values of user-defined nominal types__
_Call functions directly from the instance name_

```swift
struct Incrementer {
    var value: Int

    // new in Swift 5.2
    mutating func callAsFunction(add number: Int) {
        value += number
    }
}

var inc = Incrementer(value: 5)
inc(add: 1) // inc.value = 6
inc(add: 4) // inc.value = 10
```

^This change introduces new special functions called `callAsFunction`: 
what's special about them is that, on the call site, we can skip the function name and directly pass the parameters on the instance name.

^we can now apply the call syntax directly on the instance name, without having to explicitly call a declared function.

^Callable values are values that define function-like behavior and can be called using function call syntax.

^Values that have a method whose base name is `callAsFunction` can be called like a function.
^call by skipping the function name and call id directly on the instance name.

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

---

# [fit] Swift 
# [fit] Report

---

# [SR-6118](https://bugs.swift.org/browse/SR-6118)
__mechanism to hand through #file/#line in subscripts__
_Subscripts default arguments!_

```swift
struct Subscriptable {
  //                       ↓ new in Swift 5.2
  subscript(x: Int, y: Int = 0) { 
    ...
  }
}

let s = Subscriptable()
print(s[2])
```

^

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
[_github.com/zntfdr/talks_](https://github.com/zntfdr/talks/)

Resources:
[_github.com/apple/swift-evolution_](https://github.com/apple/swift-evolution)
[_github.com/apple/swift_](https://github.com/apple/swift)
[_forums.swift.org_](https://forums.swift.org)

Slides Style:
[_jessesquires.com_](http://jessesquires.com) *•* [_@jesse\_squires_](https://twitter.com/jesse_squires)

---

# [fit] *What's New in*

# [fit] *Swift* _**5.2**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)