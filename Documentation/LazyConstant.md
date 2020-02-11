# LazyConstant

A property wrapper which delays instantiation until first read access and prevents
changing or mutating its wrapped value.

``` swift
@propertyWrapper public struct LazyConstant<Value>
```

Usage:

``` 
@Lazy var result = expensiveOperation()
...
print(result) // expensiveOperation() is executed at this point

result = newResult // Compiler error
```

As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.

> Note: This wrapper prevents reassigning the wrapped property value but *NOT* the wrapper itself. Reassigning the wrapper `_value = LazyConstant(wrappedValue: "Hola!")` is possible and since wrappers themselves need to be declared variable there is no way to prevent it.

## Initializers

## init(wrappedValue:)

Creates a constnat lazy property with the closure to be executed to provide an initial value once the wrapped property is first accessed.

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
