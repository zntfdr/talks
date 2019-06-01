theme: Letters from Sweden, 2
autoscale: true
build-lists: true

# [fit] *What's New in*

# [fit] *Swift* _**5.1**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

---

# [fit] Swift 
# [fit] Evolution

^Swift is growing and evolving, guided by a community-driven process referred to as the "Swift Evolution" process.
Swift Evolution is the process used by the Swift Comminunity to bring new features and changes into the language.

---

# [SE-0068](https://github.com/apple/swift-evolution/blob/master/proposals/0068-universal-self.md)
__Expanding Swift Self to class members and value types__
_Improving use of Swift metatypes_

```swift
class APIManager {
    class var endpoint: String { return "api.dev.startup.com" }

    func printDebugEndpoint() {
        // new in Swift 5.1
        print(Self.endpoint)
    }
}

class APIProductionManager: APIManager {
    override class var endpoint: String { return "api.startup.com" }
}

APIProductionManager().printDebugEndpoint() // prints api.startup.com
```

^Oldest proposal implemented in 5.1: aging back to 2016!
You might have seen Self used before in protocols extensions and similar, now it can be used in the class bodies as well.
In Swift 5 we had to use `type(of: manager).endpoint` to get the correct behaviour.
Within a class scope, Self means "the dynamic class of self".
Previously we'd use `Self` mainly in protocols like this:
extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}

---

# [SE-0240](https://github.com/apple/swift-evolution/blob/master/proposals/0240-ordered-collection-diffing.md)
__Ordered Collection Diffing__
*👋🏻 IGListKit*

```swift
// Swift 5 😂
tableView.reloadData()

// Swift 5.1
let difference = newArray.difference(from: oldArray)

//                              custom convenience method 👇🏻
let (deletedIndexPaths, insertedIndexPaths) = computeIndexPaths(from: difference)

tableView.performBatchUpdates({ [weak tableView] in
  tableView?.deleteRows(at: deletedIndexPaths, with: .automatic)
  tableView?.insertRows(at: insertedIndexPaths, with: .automatic)
})

```

---

# [SE-0242](https://github.com/apple/swift-evolution/blob/master/proposals/0242-default-values-memberwise.md)
__Synthesize default values for the memberwise initializer__
*Remove all the `init`s!*

```swift
struct Dog {
    var age: Int = 0
    var name: String

    // Synthesized initializer in Swift 5
    init(age: Int, name: String)

    // Synthesized initializer in Swift 5.1
    init(age: Int = 0, name: String)
}

```

---

# [SE-0244](https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md)
__Opaque Result Types__
*Easy Type Erasure*

```swift
protocol Shape { /*...*/ }

// Functions returning `some ..` will *always* return the same
// type of instances, without leaking details on which type exactly.
// This is guaranteed at *compile time* 
func f() -> some Shape {
  return ... 
}

// We can now use generic protocols as return types
func f2() -> some Equatable {
    return ...
}
```

---

# [SE-0245](https://github.com/apple/swift-evolution/blob/master/proposals/0245-array-uninitialized-initializer.md)
__Add an Array Initializer with Access to Uninitialized Storage__
*Create arrays with specified capacity*

```swift
//  (up to) how many elements the array is going to be 👇🏻
let randomNumbers = [Int](unsafeUninitializedCapacity: 10) {
    buffer, initializedCount in
    for i in 0..<10 { buffer[i] = Int.random(in: 0...5) }

    // set 👇🏻 with the final number of elements in the array
    initializedCount = 10

    // It's ok to not use all the capacity you've
    // asked for, but don't go over that number 💥
}
```

---

# [SE-0247](https://github.com/apple/swift-evolution/blob/master/proposals/0247-contiguous-strings.md)
__Contiguous Strings__
*Improve UTF8 string operation performance and APIs*

```swift
let myString = "Swift 5.1 is awesome 🚀"

// Swift 5: generates utf8 representation first, might fail
myString.utf8.withContiguousStorageIfAvailable { body -> () in
    // prints UTF8 representation
    body.forEach { print($0) }
}

// Swift 5.1: generates *continuos* utf8 if necessary, doesn't fail
myString.withUTF8 { body in
    // prints UTF8 representation
    body.forEach { print($0) }
}
```

^“Contiguous strings” are strings that are capable of providing a pointer and length to validly encoded UTF-8 contents in constant time.

---

# [SE-0248](https://github.com/apple/swift-evolution/blob/master/proposals/0248-string-gaps-missing-apis.md)
__String Gaps and Missing APIs__
*More String, Unicode, Character Improvements*

```swift
guard let airplane = Unicode.Scalar(9992) else { return }
print(airplane) // prints ✈︎

// prints UTF-8 representation
airplane.utf8.forEach { print($0) } // prints 226, 156, 136

let airplaneWidth = Unicode.UTF8.width(airplane)
print(airplaneWidth) // prints 3

let isASCII = Unicode.UTF8.isASCII(codeUnit)
print(isASCII) // prints true
```

---

# [SE-0251](https://github.com/apple/swift-evolution/blob/master/proposals/0251-simd-additions.md)
__SIMD additions__
*Remove all your SIMD extensions*

```swift
let onesVector = SIMD4<Int>.one // generates a vector with 1 in all elements
print(onesVector) // prints SIMD4<Int>(1, 1, 1, 1)

let vector = SIMD4<Double>(1.0, 2.0, 4.0, 8.0)
print(vector.min(), vector.max()) // prints 1.0 8.0

let lowerVector = SIMD4<Double>(repeating: 1.5)
let upperVector = SIMD4<Double>(repeating: 4.5)
let clampedVector = vector.clamped(lowerBound: lowerVector, upperBound: upperVector)
print(clampedVector) // prints SIMD4<Double>(1.5, 2.0, 4.0, 4.5)

let sum = vector.sum()
print(sum) // prints 15 (= 1.0 + 2.0 + 4.0 + 8.0)
```

^ Single instruction, multiple data (SIMD), basically vectors and matrices operations (gross summary).

---

# [SE-0252](https://github.com/apple/swift-evolution/blob/master/proposals/0252-keypath-dynamic-member-lookup.md)
__Key Path Member Lookup__
*Keypath-only dynamicMembers 👀*

```swift
@dynamicMemberLookup struct TwitterUser {
    var displayName: String
    var handle: String

    // new in Swift 5.1
    subscript<U>(dynamicMember keyPath: WritableKeyPath<Self, U>) -> U? {
        return self[keyPath: keyPath]
    }
}

let user = TwitterUser(displayName: "Federico Zanetello", handle: "@zntfdr")
let userHandle = user[dynamicMember: \TwitterUser.handle]
print(userHandle2) // prints Optional("@zntfdr")
```

---

# [SE-0254](https://github.com/apple/swift-evolution/blob/master/proposals/0254-static-subscripts.md)
__Static and class subscripts__
*Subscripts, subscripts everywhere*

```swift
enum HTTPStatusCode: Int, Error {
    case badRequest = 400, unauthorized, /* ... */, notFound // ...

    // new in 5.1
    public static subscript(_ statusCode: Int) -> HTTPStatusCode? {
        return HTTPStatusCode(rawValue: statusCode)
    }
}

let errorStatusCode = HTTPStatusCode[404]! 
// errorStatusCode is HTTPStatusCode.notFound
```

---

# [SE-0255](https://github.com/apple/swift-evolution/blob/master/proposals/0255-omit-return.md)
__Implicit returns from single-expression functions__
*The less code, the better*

```swift
override func tableView(_ tableView: UITableView, 
                        numberOfRowsInSection section: Int) 
                        -> Int {
    5
}
// no longer need for `return` in one liner functions 🎉
```

---

# [fit] Swift 
# [fit] Report

---

# [SR-7799](https://bugs.swift.org/browse/SR-7799)
__Matching optional enums against non-optional values__
*No more `case .x?:`*

```swift
enum PRStatus { case open, close }

let optionalEnum: PRstatus? = .open

switch optionalEnum {
  case .open: break
  case .close: break
  case nil: break
}
```

---

# [SR-2688](https://bugs.swift.org/browse/SR-2688)
__autoclosure does not support closure typealias__
*@autoclosure ❤️ typealias*

```swift
// This code doesn't compile in Swift 5 
// (but does in 5.1)
class Foo {
  typealias FooClosure = () -> String
  func fooFunc(closure: @autoclosure FooClosure) {}
}
```

---

# [fit] & more!

---

# [fit] _**Module**_

# [fit] _Stability_

Unlocks Swift framework *binaries* distribution 🚀

---

# [fit] Links

Resources:
[_github.com/apple/swift-evolution_](https://github.com/apple/swift-evolution)
[_github.com/apple/swift_](https://github.com/apple/swift)
[_forums.swift.org_](https://forums.swift.org)
[_whatsnewinswift.com_](http://www.whatsnewinswift.com) *•* [_@twostraws_](https://twitter.com/twostraws)

Slides Style:
[_jessesquires.com_](http://jessesquires.com) *•* [_@jesse\_squires_](https://twitter.com/jesse_squires)

---

# [fit] *What's New in*

# [fit] *Swift* _**5.1**_

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)