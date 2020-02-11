# NestableCodingKey

Use this instead of `CodingKey` to annotate your `enum CodingKeys: String, NestableCodingKey`.
Use a `/` to separate the components of the path to nested keys

``` swift
public protocol NestableCodingKey: CodingKey
```

## Inheritance

`CodingKey`

## Required Properties

## path

``` swift
var path: [String]
```

## Generically Constrained Members

### where Self: RawRepresentable, Self.RawValue == String

#### init?(stringValue:)

``` swift
init?(stringValue: String)
```

#### stringValue

``` swift
var stringValue: String
```

#### init?(intValue:)

``` swift
init?(intValue: Int)
```

#### intValue

``` swift
var intValue: Int?
```

#### path

``` swift
var path: [String]
```
