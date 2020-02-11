# Lazy

A property wrapper which delays instantiation until first read access.

``` swift
@propertyWrapper public struct Lazy<Value>
```

It is a reimplementation of Swift `lazy` modifier using a property wrapper.
As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.

Usage:

``` 
@Lazy var result = expensiveOperation()
...
print(result) // expensiveOperation() is executed at this point
```

As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.

## Initializers

## init(wrappedValue:)

Creates a lazy property with the closure to be executed to provide an initial value once the wrapped property is first accessed.

``` swift
public init(wrappedValue constructor: @autoclosure @escaping () -> Value)
```

This constructor is automatically used when assigning the initial value of the property, so simply use:

``` 
@Lazy var text = "Hello, World!"
```

## Properties

## wrappedValue

``` swift
var wrappedValue: Value
```

## Methods

## reset()

Resets the wrapper to its initial state. The wrapped property will be initialized on next read access.

``` swift
public mutating func reset()
```
