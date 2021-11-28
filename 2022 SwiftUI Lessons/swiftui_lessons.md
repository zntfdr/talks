theme: Letters from Sweden, 5
autoscale: true
build-lists: false

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

^Hello everyone my name is .. and I'm the creator of fivestars.blog.  

^In my website I take deep dives into inner workings and behind the scenes of what is Swift and iOS development today.  

^However, in this talk I'd like to take a different approach, and instead, I'm happy to share with you some of the lessons I've learned during the past three years of building and shipping SwiftUI apps. From the perspective of a UIKit and AppKit developer.  

^Let's get started!

---

<!-- Lesson 1 -->

# [fit] SwiftUI
# [fit] is *not*
# [fit] UIKit 2

^Lesson number one: SwiftUI is not UIKit 2  

^We start with a big one right away.

---

[.build-lists: true]

# SwiftUI is not UIKit 2

- Complete paradigm shift (imperative ➡️ declarative)
- We're all starting from scratch
- Knowledge of earlier UI framework is:
  - 👍🏻 insightful, but not helpful
  - 😮 might even be a disadvantage 

^With SwiftUI, things are just done in a complete different way.  
Most importantly, we moved from imperative SDKs to a declarative one.  

^It doesn't matter if we're just getting started with iOS (or macOS) development, or if we have over a decade of experience. We're all stating from scratch.  

^While knowledge of previous UI frameworks gives us very good insights on how things work behind the scenes, it's not really helpful when we move to SwiftUI.  

^Actually, it might even be a disadvantage, as we come with a big baggage of expectations that are simply not true in SwiftUI. 

^One example of expectation that is no longer true is about view ownership.

---

# [fit] SwiftUI Views 
# [fit] are *recipes*

^Unlike previous frameworks, in SwiftUI we no longer own views. Instead, our declarations are more like recipes...

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# SwiftUI Views are recipes

- we declare how views look and behave...
- ...but no longer manage transitions
- we give up full control on views

^..where we specify the ingredients,  

^but it's SwiftUI that does the cooking

^Most things we're used to in UIKit/AppKit become implementation details

^let's make an example of this

---

[.text: #fff, text-scale(1.5)]
[.code: auto(1)]

# New way to make changes via state

[.code-highlight: all]
^In earlier frameworks, if we had to change the background color of a view, all we needed was grab a reference of that view and set its `backgroundColor` property.  

^Now, SwiftUI is state-driven. We no longer make such direct changes ourselves.  

[.code-highlight: 2]
^Instead, we use a few special property wrappers like the `@State` shown here

[.code-highlight: 2, 6]
^...and make our view observe and react to that state.  

[.code-highlight: 8-12]
^In this case we change our color via a button define right here in the view.  

[.code-highlight: all]
^Something that might be curious coming from earlier frameworks is that only this view and nobody else can directly change its own state. How can other views or models change the state belonging to other views?

```swift
struct FSView: View {
  @State private var backgroundColor: Color = .white

  var body: some View {
    ZStack {
      backgroundColor.ignoresSafeArea()

      Button("Change background color") {
        backgroundColor = [.red, .white, .black]
          .filter { $0 != backgroundColor }
          .randomElement()!
      }
    }
  }
}
```

![right autoplay 50%](videos/colors.mp4)

---

[.text: #fff, text-scale(1.5)]
[.code: auto(1)]

# New View communication ways

- Bindings

[.code-highlight: all]
^In order to answer that question, we need to look at the new communication patterns in SwiftUI.
^Probably the most common one is via bindings, shown here in this example

[.code-highlight: 2]
^Like before, we have a state owned by a view.

[.code-highlight: 7]
^However, we now share it with another view, which can both read and write that state.

[.code-highlight: all]
^It's important to understand that we still only have one state, and only our original view is the the sole owner of it, however we can now share such state with as many views as we want. 

```swift
struct FSView: View {
  @State private var isOn = false

  var body: some View {
    Toggle(
      "Enable X", 
      isOn: $isOn
    )
  }
}
```

![right autoplay 50%](videos/toggle.mp4)

<!-- # [fit] *State* 
# is the new king -->
<!-- ---

# New View communication

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

[.code-highlight: all]

[.code-highlight: 2, 8-12]

- Closures

```swift
struct FSView: View {
  @State var backgroundColor: Color = .white

  var body: some View {
    ZStack {
      backgroundColor.ignoresSafeArea()

      Button("Change background color") {
        backgroundColor = [.brown, .cyan, .indigo, .mint, .teal]
          .filter { $0 != backgroundColor }
          .randomElement()!
      }
    }
  }
}
``` -->

---

# [fit] It's *expected* 
# [fit] to *struggle* when 
# [fit] moving to SwiftUI

^all of the concepts we've seen so far are alien to anyone coming from UIKit and AppKit. It goes without saying but...

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# The SwiftUI struggle

- even simple things are going to be hard 
- all of us is still figuring it out
- when people say something is impossible in SwiftUI, it means they haven’t figured it out yet 
- the struggle is real...until things will \*just\* click

^even things like presenting a sheet or popping to the root of a navigation stack, because we've been working with a different mindset  

^The SDK is very new and patterns are still evolving, you're not alone, we're all still figuring out things

^A word of caution, don't believe everything you read online

^And yes, it's going to be hard at first, until we start thinking the swiftui way, then things will just click and then there's no way back.

---

<!-- Lesson 2 -->

# [fit] *Everything* 
# [fit] is a `View`,
# [fit] *not every `View`*
# [fit] is a view

^Moving on to the next lesson, it's important to understand that pretty much everything in SwiftUI is a view, but not every view is a view.  

^Concepts like UIViewControllers, delegates and similar have been removed from SwiftUI. For example...

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# Events are observed and delivered to views

[.column]

- `onAppear`
- `onDisappear`
- `task`
- `onReceive`
- `onChange`

[.column]

- `onDrag`
- `onDrop`
- `onHover`
- `onSubmit`
- …

^For example...all sort of key events are now delivered directly to views.
^Things like appear and disappear events
^state changes events
^and many more like drag and drop, hover etcetera

^However, just because things are delivered to views, it doesn't mean that we cannot properly separate and define separate entities with separate responsibilities. For example...

---

# `View`s can be containers[^2]

[.code-highlight: all]
^For example views can be containers...Container views are views that don't explicitly define any UI themselves. Here we see an example of such views

[.code-highlight: 1,4,10,11]
^It's a typical view declaration, with a body and everything

[.code-highlight: 2]
^It comes with a model, where our view core logic will reside

[.code-highlight: 5-9]
^Note how this view has no UI.

[.code-highlight: 5,8]
^Instead, a container view purpose is to declare what is the actual UI. In this case implemented in this Other FSListUI view

[.code-highlight: 7,9]
^and, most importantly, we forward the business logic events to the model, which is where we use all the gathered knowledge to decide what's next for our app.

[.code-highlight: all]
^Containers are just one example...another one most of us are familiar with is the coordinator pattern.

[.code: auto(1)]

```swift
struct ContainerView: View {
  @StateObject var model = ContainerModel()

  var body: some View {
    FSListUI(
      elements: model.elements,
      onElementTap: model.onTap(element:) 
    ) 
    .onAppear(perform: model.onAppear) 
  }
}
```

[^2]: https://swiftwithmajid.com/2019/07/31/introducing-container-views-in-swiftui/

---

[.code: auto(1), text-scale(1.5)]


[.code-highlight: all]
^In the coordinator pattern our app flow logic is extracted away from view controllers and brought to a coordinator entity that has no UI knowledge, but knows and controls the overall app state.
^Similarly to container views, in SwiftUI even coordinators are views.

[.code-highlight: 1, 5, 14, 15]
^Like before, the coordinator in SwiftUI is just another view.
In this example we show just a simple generic 2-screens flow, but it can be much more complicated than that.

[.code-highlight: 2]
^A typical coordinator will manage its own state, tracking at which step in the flow we are,

[.code-highlight: 3, 11]
^At the end of the flow, the coordinator will trigger a completion block, which will report the end to the flow to another coordinator higher in the hierarchy

[.code-highlight: 6-13]
^All it's left for the coordinator to do is define in its body is the screens for the different steps in its flow.

[.code-highlight: 9,11]
^Note how we pass to each view a closure that will be used to report back to the coordinator, which is then used to continue with the rest of the flow.

[.code-highlight: all]
^Once again, like before, this view doesn't declare any UI whatsoever, instead, it's a container that receive events and decide what to show next.

# SwiftUI coordinator architecture[^1]

```swift
struct FlowCoordinator: View {
  @State private var flow = NFlow<Screen>(root: .firstScreen)
  var onCompletion: () -> Void

  var body: some View {
    NStack($flow) { screen in
      switch screen {
        case .firstScreen:
          FirstScreen(onCompletion: { flow.push(.secondScreen) })
        case .secondScreen:
          SecondScreen(onCompletion: onCompletion)
      }
    }
  }
}
```

[^1]: https://github.com/johnpatrickmorgan/FlowStacks

---

[.footer: ⠀]

# [fit] SwiftUI is 
# [fit] _slow_*

^Another important lesson in SwiftUI is that it's slow....with a huge asterisk.

---

[.footer: *if we’re not careful]

# [fit] SwiftUI is 
# [fit] _slow_*

^With SwiftUI all sort of optimizations become implementation details, meaning that our apps should get faster by just by building them with newer SDKs. However, there's a ceiling on how much we get for free.

---

[.text: #fff, text-scale(1.5)]

# SwiftUI is slow*

- SwiftUI is lazy
- SwiftUI is as performant as our code make it so:
  - The more parameters/states/dependencies a view has, the more trouble[^1]
  - Isolate state as much as possible[^2]
  - Have each view observe as little as possible[^3]

^it won’t compute things unless we tell SwiftUI so, from our views definition, e.g. think preference keys propagation

^

[^1]: https://www.fivestars.blog/articles/app-state/

[^2]: https://www.wwdcnotes.com/notes/wwdc21/10022/

[^3]: https://github.com/cookednick/Observable

---

# [fit] Feedback ⠀⠀⠀⠀⠀
# [fit] Assistant[^1] ⠀⠀⠀⠀ ⠀
# [fit] is your ⠀⠀ ⠀⠀
# [fit] *(new) friend* ⠀

![135% original](images/splashfa.png)


[^1]: https://feedbackassistant.apple.com

^The last lesson I want to leave you today is that SwiftUI is still very new, new patterns have been introduced at every major iOS release, and old patterns have been deprecated.  

^Things have and will change for a few more years.  

^Similar to Swift evolution, the SwiftUI team listens to the community feedback: I've never received as many responses, and closed so many tickets, as when I send feedback on SwiftUI.

---

[.background-color: #ae52d8]
[.text: #fff, text-scale(1.5)]

# Feedback Assistant pro tips

- Be as narrow and concise as possible
- File as early as possible
- Follow-up when new SDKs are out
- Describe your case (for suggestions)
- Add reproduction code (for bugs)
- Bonus: attach a video demo

^File as early as possible (during beta period)

---
<!-- 
# [fit] Is SwiftUI 
# [fit] *production-ready*? 

---

# [fit] Are *you* ready 
# [fit] to ship
# [fit] *production-quality*
# [fit] SwiftUI code?

--- -->

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