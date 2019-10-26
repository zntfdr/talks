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
struct Adder {
    var base: Int

    // new in Swift 5.2
    func callAsFunction(_ x: Int) -> Int {
        return base + x
    }
}

let add3 = Adder(base: 3)
add3(10) // => 13
```

^Callable values are values that define function-like behavior and can be called using function call syntax

^Values that have a method whose base name is `callAsFunction` can be called like a function.

^let myStruct = try? JSONDecoder().decode([MyCodableStruct].self, from: data)
let myStruct = try? JSONDecoder()(decode: [MyCodableStruct].self, from: data)

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