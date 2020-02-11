# ServiceLocator.Error

``` swift
public enum Error
```

## Inheritance

`Swift.Error`

## Enumeration Cases

## duplicateService

``` swift
case duplicateService(: ServiceName)
```

## duplicateLazyService

``` swift
case duplicateLazyService(: ServiceName)
```

## inexistentService

``` swift
case inexistentService
```

## serviceTypeMismatch

``` swift
case serviceTypeMismatch(expected: Any.Type, found: Any.Type)
```

## lazyServiceTypeMismatch

``` swift
case lazyServiceTypeMismatch(expected: Any.Type, found: Any.Type)
```
