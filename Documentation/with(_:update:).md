# with(\_:update:)

## with(\_:update:)

Swifty alternative to set multiple properties of a given item.
The given item is passed to the given closure and can be mutated from there

``` swift
@discardableResult public func with<T>(_ item: T, update: (inout T) throws -> Void) rethrows -> T
```
