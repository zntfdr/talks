theme: Letters from Sweden, 5
autoscale: true
build-lists: true

# [fit] *What's New in*

# [fit] *Swift* _**5.4**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

---

# [fit] Swift 
# [fit] Evolution

^Swift is growing and evolving, guided by a community-driven process referred to as the "Swift Evolution" process.
Swift Evolution is the process used by the Swift Community to bring new features and changes into the language.

---

# [SE-0287](https://github.com/apple/swift-evolution/blob/master/proposals/0287-implicit-member-chains.md)
__Extend implicit member syntax to cover chains of member references__
_Implicit chains all the things!_

```swift
let milky: Color = .white.opacity(0.5)
// ^ Swift 5.4: Allowed
// ^ Swift <=5.3: ERROR: Cannot infer contextual base in reference to member 'white'
```

^
the resulting type of the chain must be the same as the (implicit) base

---

# [SE-0284](https://github.com/apple/swift-evolution/blob/master/proposals/0284-multiple-variadic-parameters.md)
__Allow Multiple Variadic Parameters in Functions, Subscripts, and Initializers__
_Last restriction: parameters which follow a variadic parameter must be labeled_

```swift
func foo(_ a: Int..., b: Double..., c: String...) { }
```

^Only one variadic parameter is allowed per parameter list

---

# [S-]()
__title__
_comment_

```swift

```

^

---

# [fit] Swift 
# [fit] Report

---

# [SR-10069](https://bugs.swift.org/browse/SR-10069)
__Local functions cannot be overloaded__
_Nice edge case fixed_

```swift
func outer(x: Int, y: String) {
  func doIt(_: Int) {}
  func doIt(_: String) {} // Swift <=5.3 Error: Definition conflicts with previous value
  doIt(x) // calls the first 'doIt(_:)' with an Int value
  doIt(y) // calls the second 'doIt(_:)' with a String value
}
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

# [fit] *Swift* _**5.4**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)