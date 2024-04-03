# CursedControlFlow
[![MIT License](https://badgen.net/github/license/micromatch/micromatch)](https://mit-license.org/) 
[![Swift Package Manager compatible](https://badgen.net/badge/SPM/Compatible?color=green)](https://github.com/apple/swift-package-manager)
[![Platforms](https://badgen.net/badge/icon/iOS%20%7C%20macOS%20%7C%20macOS%20Catalyst%20%7C%20tvOS%20%7C%20visionOS%20%7C%20watchOS?icon=apple&label&color=grey)](https://apple.com/developer)

A set of utilities to fully bring the Swift language into the modern age

## Why `CursedControlFlow`

Ever been writing some modern Swift code when suddenly you hit on something like the following?

```swift
let temp = 25

let theString: String
if temp > 30 {
    print("It's too hot")
    theString = "Soooo HOT"
} else if temp < 0 {
    print("It's damn freezing")
    theString = "Hell froze over"
} else {
    print("It's ok")
    theString = "Nice weather"
}

print(theString) // Nice weather
```

What is this? _the 90s_? Are these the lyrics from a Radiohead song? Sprinkle some semicolons in there and you'll start
hearing disco while you run the code on the department's PDP-11.

This, and many others, are concessions to ancient customs that have no place in a modern Swift world. Swift deserves and
needs more modern alternatives.

Fortunately, Swift gives us the tools to make Swift more like Swift.

And we will be using them add what is needed until all of Swift looks and behaves like a truly modern programming
language. 

## if.then.else

With these additions you can write the above code example in a much fresher way, as follows:

```swift
let temp = 25

let theString = `if`(temp > 30).then {
    print("It's too hot")
    theString = "Soooo HOT"
}.elseIf(temp < 0) {
    print("It's damn freezing")
    theString = "Hell froze over"
}.else {
    print("It's ok")
    theString = "Nice weather"
}

print(theString) // Nice weather
```

Besides the much, much nicer syntax, notice further advantages over the current state of the language:

- You can return whatever value you want from the whole flow control without being subject to the current bizarre
limitations of `if...` expressions.
- You can use either expressions or blocks at any point in the control flow, alternating as needed. For example we could
do the following.

```swift
let theString = `if` {
    log("fetching \"hot\" temperature")
    let hot = fetchHot()
    return temp > hot
}.then {
    // Everything else is the same…
}
```

## Future Directions

- `if.then.else` doesn't currently support `throw` or `async`. Some heavy duty copy/pasting should take care of that.
- Neither does it support all the fancy scoping and variable declaration + unwrapping sugar that Swift provides. A
`Result`-oriented solution is being designed.
- `for` loops deserve to die.
- We can do better than `switch` statements.
