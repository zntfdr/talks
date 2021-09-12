theme: Letters from Sweden, 5
autoscale: true
build-lists: true

# [fit] *SwiftUI*
# [fit] _**Lessons**_

![100% original](images/splash.jpg)

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

[.header-strong: #000]
[.text-emphasis: #000]
[.text-strong: #000]
[.text: #000]
[.header-emphasis: #ffffff]

^Hello everyone my name is .. and I'm the creator of fivestars.blog, most importantly for this talk, I've been shipping SwiftUI apps since iOS 13 came out, with navigation, deep link and many other feature users expect from a modern app.

^In this talk I'd like to share some of the lessons I've learned in the past three years.

---

# [fit] SwiftUI
# [fit] is *not*
# [fit] UIKit 2

^throw away your decade of experience
^hard truth is “seniors” have forgotten to keep learning
^to this day I receive applicants that use 7 years old collection apis instead of the 3 years old snapshots

---

# [fit] It’s *expected* 
# [fit] to *struggle* when 
# [fit] moving to SwiftUI

^It’s like somebody fluent in one language is surprised that it cannot be as fluent in another one. 
^Yes, they share some grammars 
^SwiftUI doesn’t care about your 10 years of experience in UIKit
^When people day it’s in possible, it means they haven’t figured it out and give up. 

---

# [fit] *Everything* 
# [fit] is a `View`,
# [fit] *not every `View`*
# [fit] is a view. 

^Think like flow stacks as coordinator, containers..

---

# [fit] SwiftUI is 
# [fit] _slow_

^if we’re not careful. 
^Use your architecture or the Observing repository to avoid doing stuff
^SwiftUI is lazy, it won’t compute things unless we ask for, e.g. think preference keys propagation

---

# [fit] Is SwiftUI 
# [fit] *production ready*? 

---

# [fit] Are *you*? 

---

# [fit] *SwiftUI*
# [fit] _**Lessons**_

![100% original](images/splash.jpg)

## <br>
## __*Federico Zanetello*__

★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

[.header-strong: #000]
[.text-emphasis: #000]
[.text-strong: #000]
[.text: #000]
[.header-emphasis: #ffffff]

<!-- 
More ideas:

- To truly understand SwiftUI, you need to truly understand Swift. Property wrappers, async/await, callable as function in env values

- We don’t set or change how things look/behave. Instead we change their declarate
- Overlay/background are your friends, Spacer + stacks are enemies
- Everything is a state, SwiftUI changes 
- Create raw views to avoid unnecessary redraws when a @State/etc will trigger the body redraw will be triggered,
 -->