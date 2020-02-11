# NestedKey

Use this to annotate the properties that require a depth traversal during decoding.
The corresponding `CodingKey` for this property must be a `NestableCodingKey`

``` swift
@propertyWrapper public struct NestedKey<T: Decodable>: Decodable
```

``` 
struct Contact: Decodable, CustomStringConvertible {
   var id: String
   @NestedKey
   var firstname: String
   @NestedKey
   var lastname: String
   @NestedKey
   var address: String
 
   enum CodingKeys: String, NestableCodingKey {
       case id
       case firstname = "nested/data/user/firstname"
       case lastname = "nested/data/user/lastname"
       case address = "nested/data/address"
   }
}
```

## Inheritance

`Decodable`

## Nested Types

  - [NestedKey.AnyCodingKey](NestedKey_AnyCodingKey)

## Initializers

## init(from:)

``` swift
public init(from decoder: Decoder) throws
```

## Properties

## wrappedValue

``` swift
var wrappedValue: T
```
