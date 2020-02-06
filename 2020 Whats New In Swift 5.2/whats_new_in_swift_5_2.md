theme: Letters from Sweden, 2
autoscale: true
build-lists: true

# [fit] *What's New in*

# [fit] *Swift* _**5.2**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

---

# [fit] Swift 
# [fit] Evolution

^Swift is growing and evolving, guided by a community-driven process referred to as the "Swift Evolution" process.
Swift Evolution is the process used by the Swift Comminunity to bring new features and changes into the language.

---

# [SE-0253](https://github.com/apple/swift-evolution/blob/master/proposals/0253-callable.md)
__Callable values of user-defined nominal types__
_Introducing "statically" callable values_

```swift
struct Incrementer {
    var value: Int

    // new in Swift 5.2
    mutating func callAsFunction() {
        value += 1
    }
}

var inc = Incrementer(value: 5)
inc() // inc.value = 6
inc() // inc.value = 7
```

^Callable values are values that define function-like behavior and can be called using function call syntax

^Values that have a method whose base name is `callAsFunction` can be called like a function.

^let myStruct = try? JSONDecoder().decode([MyCodableStruct].self, from: data)
let myStruct = try? JSONDecoder()(decode: [MyCodableStruct].self, from: data)

^func callAsFunction argument labels are required at call sites.
Multiple func callAsFunction methods on a single type are supported.
mutating func callAsFunction is supported.
func callAsFunction works with throws and rethrows.
func callAsFunction works with trailing closures.

---

# [fit] Swift 
# [fit] Report

---

# [SR-6118](https://bugs.swift.org/browse/SR-6118)
__mechanism to hand through #file/#line in subscripts__
_Subscripts can now declare default arguments!_

```swift
struct Subscriptable {
  //                       ↓ new in Swift 5.2
  subscript(x: Int, y: Int = 0) { 
    ...
  }
}

let s = Subscriptable()
print(s[0])
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

^Previously this would crash the compiler

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
  let ptr = UnsafePointer(&i) // dangling pointer warning
  
  let s1 = S(ptr: [1, 2, 3]) // argument should be a pointer that outlives the call
  
  let s2 = S(ptr: "hello") // argument should be a pointer that outlives the call
}
```


^ // warning: initialization of 'UnsafePointer<Int8>' results in a dangling pointer
^ // warning: passing '[Int8]' to parameter, but argument 'ptr' should be a pointer that outlives the call to 'init(ptr:)'
^ // warning: passing 'String' to parameter, but argument 'ptr' should be a pointer that outlives the call to 'init(ptr:)'

^All 3 of the above examples are unsound because each argument produces a temporary pointer only valid for the duration of the call they are passed to. Therefore the returned value in each case references a dangling pointer.

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

---

# [S-]()
__title__
_comment_

```swift

```

^

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

# [fit] *Swift* _**5.2**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)