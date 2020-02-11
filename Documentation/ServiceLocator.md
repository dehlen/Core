# ServiceLocator

``` swift
public final class ServiceLocator
```

## Nested Types

  - [ServiceLocator.Error](ServiceLocator_Error)
  - [ServiceLocator.RegisteredService](ServiceLocator_RegisteredService)

## Nested Type Aliases

## ServiceName

``` swift
Typealias(context: Optional("ServiceLocator"), attributes: [], modifiers: [public], keyword: "typealias", name: "ServiceName", initializedType: Optional("String"), genericParameters: [], genericRequirements: [])
```

## LazyInit

``` swift
Typealias(context: Optional("ServiceLocator"), attributes: [], modifiers: [public], keyword: "typealias", name: "LazyInit", initializedType: Optional("() -> (Service)"), genericParameters: [Service], genericRequirements: [])
```

## Properties

## shared

``` swift
let shared = ServiceLocator()
```

## Methods

## register(name:service:)

``` swift
@discardableResult public func register<Service>(name serviceName: ServiceName? = nil, service: Service) throws -> ServiceName
```

## register(name:lazyService:)

``` swift
@discardableResult public func register<Service>(name serviceName: ServiceName? = nil, lazyService lazyInit: @escaping LazyInit<Service>) throws -> ServiceName
```

## unregister(\_:name:)

``` swift
public func unregister<Service>(_ type: Service.Type, name serviceName: ServiceName? = nil) throws
```

## unregisterAll()

``` swift
public func unregisterAll()
```

## get(name:)

``` swift
public func get<Service>(name serviceName: ServiceName? = nil) throws -> Service
```
