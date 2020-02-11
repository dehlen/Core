# LateInit

A property wrapper which lets you left a stored property uninitialized during construction and set its value later.

``` swift
@propertyWrapper public struct LateInit<Value>
```

In Swift \*classes and structures must set all of their stored properties to an appropriate initial value by the time
an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state. \*.

LateInit lets you work around this restriction and leave a stored properties uninitialized. This also means you are
responsible of initializing the property before it is accessed. Failing to do so will result in a fatal error.
Sounds familiar? LateInit is an reimplementation of a Swift "Implicitly Unwrapped Optional".

Usage:

``` 
@LateInit var text: String

// Note: Access before initialization triggers a fatal error:
// print(text) // -> fatalError("Trying to access LateInit.value before setting it.")

// Initialize later in your code:
text = "Hello, World!"
```

## Initializers

## init()

``` swift
public init()
```

## Properties

## wrappedValue

``` swift
var wrappedValue: Value
```
