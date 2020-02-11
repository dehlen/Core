# TypedNotificationCenter

``` swift
public protocol TypedNotificationCenter
```

## Conforming Types

`NotificationCenter`

## Required Methods

## post(\_:)

``` swift
func post<N: TypedNotification>(_ notification: N)
```

## addObserver(\_:sender:queue:using:)

``` swift
func addObserver<N: TypedNotification>(_ forType: N.Type, sender: N.Sender?, queue: OperationQueue?, using block: @escaping (N) -> Void) -> NSObjectProtocol
```
