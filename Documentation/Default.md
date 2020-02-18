# Default

Use this to annotate the properties with a default value if decoding fails.

``` swift
@propertyWrapper public struct Default<Provider: DefaultValueProvider>: Codable
```

``` 
struct Product: Codable {
  var name: String
  
  @Default<Empty>
  var description: String
  
  @Default<True>
  var isAvailable: Bool
  
  @Default<FirstCase>
  var type: ProductType
}
```

## Inheritance

`Codable`

## Initializers

## init()

``` swift
public init()
```

## init(wrappedValue:)

``` swift
public init(wrappedValue: Provider.Value)
```

## init(from:)

``` swift
public init(from decoder: Decoder) throws
```

## Properties

## wrappedValue

``` swift
var wrappedValue: Provider.Value
```
