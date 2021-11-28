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
^In this talk I'd like to take a different path, and instead, share with you some of the lessons I've learned during the past three years in building and shipping SwiftUI apps. Coming from a UIKit background.

<!-- most importantly for this talk, I've been shipping SwiftUI apps since the day iOS 13 came out, with navigation, deep link and many other feature users expect from any modern app.
 -->

^Let's get started!

---

<!-- Lesson 1 -->

# [fit] SwiftUI
# [fit] is *not*
# [fit] UIKit 2

^Lesson number one.
^Great, let's get rid of the big one right away.

---

[.build-lists: true]

# SwiftUI is not UIKit 2

- Complete paradigm shift
- We're all starting from scratch
- Knowledge of earlier UI framework is:
  - 👍🏻 insightful, but not helpful
  - 😮 might even be a disadvantage 

^Things are just done in a complete different way now.
^It doesn't matter if you're just getting started with iOS (or macOS) development, or if you have over a decade of experience.
^SwiftUI is a complete paradigm shift.
^While knowledge of previous UI frameworks gives us very good insights on how things work behind the scenes, it's not really helpful when we move to SwiftUI.
^Actually, it might even be a disadvantage, as we come with a big set of expectations that are simply not true in SwiftUI.
^Let's talk about some of those differences

---

# [fit] SwiftUI Views 
# [fit] are *recipes*

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# SwiftUI Views are recipes

- we declare how views look and behave
- ...but no longer manage transitions
- we give up full control on views
- most things we're used to (in UIKit/AppKit) become implementation details

^we don't actually do the cooking, SwiftUI takes care of that

---

[.text: #fff, text-scale(1.5)]

# New way to make changes via state

- @AppStorage
- @SceneStorage
- @State 
- @StateObject
- @EnvironmentObject

^Another important lesson is that change with SwiftUI is state-driven
^We don't directly tell our views to change, or subscribe and unsubscribe for events, SwiftUI does this automatically
^Instead we use a few special property wrappers like the one shown here, that SwiftUI handle for us.
^The curious part is that when a view owns a state, only that view can change it, no view model or other views can change it. So how can views change state belonging to other views?

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# New View communication

- Bindings
- SwiftUI Environment
- Closures

<!-- # [fit] *State* 
# is the new king -->
^Responder chain, delegate pattern
^When learning SwiftUI from a UIKit background, one of the most perplexing and probably baffling challenges to learn/understand is how to make 
^how to make views change based on events happening on the view model:  
in SwiftUI a view model can't just reach for the view and change its properties for example. Instead, the view <-> view-model communication happens via changes of states, 

^instead of having view models telling views to change their color, the model will change its own state that is then observed by the view.
^Communication is just one of the many aspects that has completely evolved with SwiftUI.

^all of these concepts are foreign to anyone coming from UIKit
^It goes without saying but...

---

# [fit] It’s *expected* 
# [fit] to *struggle* when 
# [fit] moving to SwiftUI

^If it isn't clear by now, let me say that again: SwiftUI is a massive shift from AppKit and UIKit.

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# The SwiftUI struggle

- the struggle is real until things will just click
- all of us is still figuring it out
- when people say that something is impossible in SwiftUI, it means that we just haven’t figured it out yet 

^thinking in swiftui
^If you're not struggling when moving from UIKit, you're probably doing it wrong
^The SDK is very new and patterns are still evolving
^This is such an important point that I've made a slide to further enphatized it.
^It’s like somebody fluent in one language is surprised that it cannot be as fluent in another one. 
^Yes, they share some grammars 

---

<!-- Lesson 2 -->

# [fit] *Everything* 
# [fit] is a `View`,
# [fit] *not every `View`*
# [fit] is a view

^Think like flow stacks as coordinator, containers..
^Good bye to concepts like UIViewControllers and other architectures like routers

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

^(for the first point) there's no delegate,
^this comes as perplexing and, sometimes, even upsetting, but most business logic happens in views.
^Most key events are delivered to views
^appear and disappear events
^state changes events
^and much more like drag and drop, hover and more

---

# `View`s can be containers[^2]

[.code-highlight: none]
^While this seems weird, it's totally OK!
^For example here we declare a container view

[.code-highlight: 1,4,10,11]
^It's a typical view declaration, with a body and everything

[.code-highlight: 2]
^It comes with a model, where our view core logic will reside

[.code-highlight: 5-9]
^Note how this view has no UI.

[.code-highlight: 5,8]
^Instead, a container view purpose is to declare what is the actual UI. In this case implemented in this Other FSListUI view

[.code-highlight: 7,9]
^and, most importantly, to forward the business logic events to the model, which then will use this knowledge to decide what's next for our app.


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

^Containers are just one example, another aspect most of us are familiar with is the Coordinator pattern.

[^2]: https://swiftwithmajid.com/2019/07/31/introducing-container-views-in-swiftui/

---

[.code: auto(1), text-scale(1.5)]

[.code-highlight: none]
^The coordinator pattern is a quite popular architecture pattern where the flow logic of our app is extracted away from view controllers and brought to a new coordinator entity that has no UI knowledge, but only know where we are within our app flow, and what to do next.
^Continuing with our lesson that not all views are actually views, in SwiftUI coordinators are also views.

[.code-highlight: 1, 5, 14, 15]
^Like before, the coordinator in SwiftUI is just another view.
In this example we show just a simple generic 2-screens flow, but it can be much more complicated than that.

[.code-highlight: 2]
^A typical coordinator will manage its own state, tracking at which step in the flow we are,

[.code-highlight: 3]
^At the end of the flow, the coordinator will trigger a completion block, which will probably be a closure that triggers a state change on another coordinator higher in the hierarchy

[.code-highlight: 6-13]
^All it's left for the coordinator to do is declare in its body the different UI views for the different steps in the flow and that's it.

[.code-highlight: 9,11]
^Note how we pass to each view a closure that will be used to trigger something within our coordinator flow.

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

^A big aspect that we give up moving to SwiftUI is the complete control on things.
^All sort of optimizations now become implementation details, meaning that we get most of them for free when we build our apps with newer SDKs.

---

[.footer: *if we’re not careful]

# [fit] SwiftUI is 
# [fit] _slow_*

^ 
^Use your architecture or the Observing repository to avoid doing stuff
^SwiftUI is lazy, it won’t compute things unless we ask for, e.g. think preference keys propagation

---

[.text: #fff, text-scale(1.5)]

- The more parameters/states/dependencies, the more trouble[^1]
- Isolate state as much as possible[^2]
- Have each view observe as little as possible[^3]

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

^SwiftUI is still very new, new patterns have been introduced at every major iOS release, and old patterns have been deprecated.
^Things have and will change for a few more years.
^The SwiftUI team listens to the community feedback, I've never received as many responses to all my feedback as after SwiftUI

---

[.background-color: #ae52d8]
[.text: #fff, text-scale(1.5)]

# Feedback Assistant pro tips

- File as many as possible
- File as early as possible
- Follow-up when new SDKs are out
- Describe your case (for suggestions)
- Add reproduction code (for bugs)
- Bonus: add a video

^File as early as possible (during beta period)

---

# [fit] Is SwiftUI 
# [fit] *production-ready*? 

---

# [fit] Are *you* ready 
# [fit] to ship
# [fit] *production-quality*
# [fit] SwiftUI code?

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