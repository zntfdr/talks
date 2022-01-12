theme: Letters from Sweden, 5
autoscale: true
build-lists: false

<!-- footnote symbols:
α, β, γ, δ, ε, θ, λ, μ, ν, π, ρ, Σ, τ, φ, χ, ψ, Ω, ω 
-->

# [fit] *SwiftUI*
# [fit] _**Lessons**_
## For UI/AppKit developers

__*Federico Zanetello*__
★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

![100% original](images/splash.jpg)

[.header-strong: #000]
[.text-emphasis: #000]
[.text-strong: #000]
[.text: #000]
[.header-emphasis: #ffffff]

^Hello everyone my name is .. and I'm the creator of fivestars.blog.  

^On my website I take deep dives into inner workings and behind the scenes of what is Swift and iOS development today.  

^However, in this talk I'd like to take a different approach, and instead, I'm happy to share with you some of the lessons I've learned during the past three years of building and shipping SwiftUI apps coming from a UIKit/AppKit developer background.  

^Let's get started!

---

<!-- Lesson 1 -->

# [fit] SwiftUI
# [fit] is *not*
# [fit] UI/AppKit 2

^Lesson number one: SwiftUI is not UIKit 2  

^We start with a big one right away.

---

[.build-lists: true]

# SwiftUI is not UIKit/AppKit 2

- Complete paradigm shift (imperative ➡️ declarative)
- We're all starting from scratch
- Knowledge of earlier UI framework is:
  - 👍🏻 insightful
  - 😕 not helpful
  - 😮 might even be a disadvantage (!!!)

^With SwiftUI, things are just done in a complete different way. We moved from multiple imperative SDKs to a single declarative one.  

^It doesn't matter if we're just getting started with building apps for Apple platforms, or if we have over a decade of experience. We're all stating from scratch.  

^While knowledge of previous UI frameworks gives us very good insights on how things work behind the scenes, it's not really helpful when we move to SwiftUI.  

^Actually, it might even be a disadvantage, as we come with a big baggage of expectations that are simply not true in SwiftUI. 

^One example of expectation that is no longer true is about view ownership...

---

# [fit] SwiftUI Views 
# [fit] are *recipes*

^In fact, this is Lesson number two: because of SwiftUI declarative nature,

^We no longer own views. 

^Instead, our view code looks more like recipes...

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# SwiftUI Views are recipes

- where we declare how views look and behave...
- ...but no longer manage transitions & similar
- we give up full control on views

^..where we specify the ingredients, such as the view behavior and look

^but it's SwiftUI that does the cooking, such as all the transitions

^Most things we're used to do in UIKit/AppKit become implementation details that we no longer need to take care of

^let's make an example of this

---

[.text: #fff, text-scale(1.5)]
[.code: auto(1)]

# New way to make changes via state

[.code-highlight: all]
^Imagine that we want to change the background color of our screen.

^previously, we'd probably grab the view on the back and set its background color

^Now, SwiftUI is state-driven. We no longer make such direct changes ourselves.  

[.code-highlight: 2]
^Instead, we define properties associated with special property wrappers like `@State` shown here

[.code-highlight: 2, 6]
^...and make our view observe and react to that state.  

[.code-highlight: 2, 8-12]
^In this case we change our color via a button defined right here in the view  

[.code-highlight: all]
^Note that backgroundColor is a state that we have defined, there's no default background color property that we can reach and set in SwiftUI.

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

![right autoplay loop 50%](videos/colors.mp4)

---

[.text: #fff, text-scale(1.5)]
[.code: auto(1)]

# New View communication ways

- Bindings

[.code-highlight: all]
^to answer that question, we need to look at the new communication patterns in SwiftUI.
One of the most common ways to do so in SwiftUI is via bindings, shown here in this example

[.code-highlight: 2]
^Like before, we have a state owned by a view.

[.code-highlight: 7]
^However, we now share it with another view, which can both read and write that state. This is possible by a binding, that we enable thanks to the dollar sign here, which is also what this Toggle view expects as a parameter.

[.code-highlight: all]
^It's important to understand that we still only have one state, and our original view is the the sole owner of it. However, we can now share this state with as many views as we want with this new pattern.  

^all of the concepts we've seen so far are alien to anyone coming from previous UI frameworks. 

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

![right autoplay loop 50%](videos/toggle.mp4)

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
# [fit] learning SwiftUI


^So let me be clear...with lesson number 3:

^even things like presenting a sheet or popping to the root of a navigation stack, become hard.  

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# The SwiftUI struggle

- even simple things are going to be hard 
- all of us are still figuring it out
- when people say something is impossible in SwiftUI, it means they haven’t figured it out yet 
- the struggle is real...until things will \*just\* click

^Because we've been working with different tools and mindset all this time.

^You're not alone, we're all still figuring things out, including the SwiftUI team at Apple.  

^A word of caution, don't believe everything you read online

^things will be hard first, things won't make sense..until we start thinking the swiftui way, then things will just click and then there's no going back, everything becomes easy

---

<!-- Lesson 2 -->

# [fit] *Everything* 
# [fit] is a `View`,
# [fit] *not every `View`*
# [fit] is a view

^Moving on to the next lesson, it's important to understand that pretty much everything in SwiftUI is a view, but not every view is a view.  

^Concepts like UIViewControllers, delegates and similar do not exist in SwiftUI. 

^With that being said..as an example, it shouldn't be surprising that...

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

^...all sort of key events are now delivered directly to views.

^...Things like appear and disappear events  

^...state changes notifications

^...and many more like drag and drop, hover etcetera

^This might sounds upsetting at first. We all know what happens when we put all our presentation and business logic in a single view controller.

^However, just because things are delivered to views, it doesn't mean that we cannot properly separate and define different entities with clear and distinct responsibilities. For example...

---

# `View`s can be containers[^α]

[.code-highlight: all]
^For example views can be containers...Container views are views that don't explicitly define any UI themselves. Here we see an example of such views

[.code-highlight: 1,4,10,11]
^It's a typical view declaration, with a body and everything

[.code-highlight: 2]
^It comes with a model, where our the business logic will reside

[.code-highlight: 5-9]
^Note how this view has no UI.

[.code-highlight: 5,8]
^Instead, the view definition is delegated to and implemented by another view, ActualUI in this example

[.code-highlight: 6]
^and, most importantly, this UI relies on our container data to decide what to display

[.code-highlight: 7,9]

^and we forward the business logic events to our model, which is where we gather the view state knowledge to decide what's next.

[.code-highlight: all]
^Containers are just one example...

^Something else most of us are probably familiar with is the coordinator pattern.

[.code: auto(1)]

```swift
struct ContainerView: View {
  @StateObject var model = ContainerModel()

  var body: some View {
    ActualUI(
      elements: model.elements,
      onElementTap: model.onTap(element:) 
    ) 
    .onAppear(perform: model.onAppear) 
  }
}
```

[^α]: https://swiftwithmajid.com/2019/07/31/introducing-container-views-in-swiftui/

---

[.code: auto(1), text-scale(1.5)]


[.code-highlight: all]
^In the coordinator pattern our app flow logic is extracted away from view controllers and brought to a coordinator entity that defines no UI, but knows and controls the overall app state and flow.  

[.code-highlight: 1, 5, 14, 15]
^Similarly to container views, in SwiftUI even coordinators are views.

[.code-highlight: 8, 10]
^In this example we define a generic 2-screens flow, but it can be much more complicated than that.

[.code-highlight: 2]
^A typical coordinator will manage its own state, tracking at which step in the flow we are,

[.code-highlight: 3]
^At the end of the flow, the coordinator will trigger a completion block, which will report the end of the flow to another coordinator higher in the hierarchy

[.code-highlight: 6-13]
^All it's left for the coordinator to do is define is the screens for the different steps in its flow.

[.code-highlight: 9,11]
^Note how we pass to each view a closure that will be used to report back to the coordinator, which is then used to continue with the rest of the flow.

[.code-highlight: all]
^Once again, like before, this view doesn't declare any UI whatsoever, instead, it's a container that receive events and decide what to show next.

^In conclusion, despite seemingly only having views at our disposal, it's still possible to separate entities and responsibilities in Swiftui.

# SwiftUI coordinator architecture[^β]

```swift
struct FlowCoordinator: View {
  @State private var routes: [Route<Screen>] = [.root(.firstScreen)]
  var onCompletion: () -> Void

  var body: some View {
    Router($routes) { screen, _ in
      switch screen {
        case .firstScreen:
          FirstScreen(onCompletion: { routes.push(.secondScreen) })
        case .secondScreen:
          SecondScreen(onCompletion: onCompletion)
      }
    }
  }
}
```

[^β]: https://github.com/johnpatrickmorgan/FlowStacks

---

# [fit] SwiftUI is 
# [fit] _slow_*

^Let's move to our fifth and important lesson: SwiftUI is slow....with a huge asterisk.

---

[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# SwiftUI is slow*

- Optimizations become implementation details
  - newer Xcode, faster app! 🏎
  - there's a limit to how much we can get for free

- *SwiftUI is as performant as our code makes it so:
  - The more parameters/states/dependencies a view has, the less performance we might get[^γ]
      - Isolate state as much as possible[^δ]
      - Publish only relevant changes
      - Make each view observe as little as possible[^ε]

^With SwiftUI all sort of optimizations become implementation details that are not managed by us. 

^meaning that our apps might get faster just by building them with a newer Xcode. 

^However, there's a limit to how much we can get for free.

^A common pitfall

^it won’t compute things unless we tell SwiftUI so, from our views definition, e.g. think preference keys propagation

^no every change in our model need to tell SwiftUI to re-evaluate our views

^Yes, SwiftUI is clever, but it still needs our help.

[^γ]: https://www.fivestars.blog/articles/app-state/

[^δ]: https://www.wwdcnotes.com/notes/wwdc21/10022/

[^ε]: https://github.com/cookednick/Observable/

---

# [fit] Feedback ⠀⠀⠀⠀⠀
# [fit] Assistant[^λ] ⠀⠀⠀⠀ ⠀
# [fit] is your ⠀⠀ ⠀⠀
# [fit] *(new) friend* ⠀

![135% original](images/splashfa.png)

[^λ]: https://feedbackassistant.apple.com

^Moving to the next lesson...SwiftUI is still very new, new patterns have been introduced at every major iOS release, and old patterns have been deprecated.  

^Things have and will change for a few more years.  

^Similar to Swift evolution, the SwiftUI team listens to the community feedback: I've never received as many responses, and closed so many tickets, as when I send feedback to Apple on SwiftUI.

---

[.background-color: #ae52d8]
[.text: #fff, text-scale(1.5)]
[.build-lists: true]

# Feedback Assistant pro tips

- Be as narrow and concise as possible
- File as early as possible
- Follow-up when new SDKs are out
- Add reproduction code (for bugs)
- Bonus: attach a video demo
- Describe your case (for suggestions)

^Be as narrow and concise as possible

^Xcode betas are released for us to make sure our app don't break and to try out new APIs

^File as early as possible, don't wait until the next release to see if maybe it's fixed (during beta period)

<!-- 
# [fit] Is SwiftUI 
# [fit] *production-ready*? 

---

# [fit] Are *you* ready 
# [fit] to ship
# [fit] *production-quality*
# [fit] SwiftUI code?

--- -->

---

# [fit] UIKit/Appkit
# [fit] are *not*
# [fit] going anywhere 🤗

^Before leaving you today, I want my last lesson to also be a reassurance for everyone. That is..

^UIKit and AppKit are here to stay.

---

[.build-lists: true]

# UIKit/Appkit are not going anywhere 🤗

- SwiftUI uses both AppKit and UIKit behind the scenes
- SwiftUI is just another tool in our belt
- it's ok to mix and match!
  - `UIViewRepresentable` `NSViewRepresentable`
  - `UIViewControllerRepresentable` `NSViewControllerRepresentable`
  - `UIHostingController` `NSHostingController`
- Feel free to experiment!

^we have plenty of bridges to bring AppkIt and UIKit to SwiftUI, and SwiftUI to AppKit and UIKit

^..and SwiftUI itself relies heavily on previous frameworks

^Similarly to having an app with a mix of Swift and Objective-C, we can build apps that use both frameworks, it's not a all or nothing.

^Last but not least: don't forget to experiment, I promise it's going to be fun!

---

# [fit] *SwiftUI*
# [fit] _**Lessons**_
## For UI/AppKit developers

__*Federico Zanetello*__
★★★★★ [_fivestars.blog_](http://fivestars.blog) *•* [_@zntfdr_](http://twitter.com/zntfdr)

![100% original](images/splash.jpg)

[.header-strong: #000]
[.text-emphasis: #000]
[.text-strong: #000]
[.text: #000]
[.header-emphasis: #ffffff]

^I'd like to thank the conference organizers this opportunity and thank you all of you for joining me in this session. 

^If you have any questions you can find me on Twitter, my handle is right here on this slide.

^I wish you a great rest of the conference!

<!-- 
More ideas:

- To truly understand SwiftUI, you need to truly understand Swift. Property wrappers, async/await, callable as function in env values

- We don’t set or change how things look/behave. Instead we change their declarate
- Overlay/background are your friends, Spacer + stacks are enemies
- Everything is a state, SwiftUI changes 
- Create raw views to avoid unnecessary redraws when a @State/etc will trigger the body redraw will be triggered,
 -->