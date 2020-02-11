# Bindable

Use like:

``` swift
public class Bindable<Value>
```

``` 
struct User {
   let name: String
   let followers: Int
}
 
class Updater {
   let user: Bindable<User> = Bindable<User>(User(name: "Foo", followers: 3))
 
   init() {
       user.update(with: User(name: "Foo", followers: 4))
   }
}
 
class Use {
   private let user: Bindable<User>
 
   init(user: Bindable<User>) {
       self.user = user
       applyBindings()
   }
 
   private func applyBindings() {
       user.bind(\.name, to: label, \.text)
       user.bind(\.followers, to: followersLabel, \.text, transform: String.init)
   }
}
```

## Initializers

## init(\_:)

``` swift
public init(_ value: Value? = nil)
```

## Methods

## update(with:)

``` swift
func update(with value: Value)
```

## bind(\_:to:\_:)

``` swift
func bind<O: AnyObject, T>(_ sourceKeyPath: KeyPath<Value, T>, to object: O, _ objectKeyPath: ReferenceWritableKeyPath<O, T>)
```

## bind(\_:to:\_:)

``` swift
func bind<O: AnyObject, T>(_ sourceKeyPath: KeyPath<Value, T>, to object: O, _ objectKeyPath: ReferenceWritableKeyPath<O, T?>)
```

## bind(\_:to:\_:transform:)

``` swift
func bind<O: AnyObject, T, R>(_ sourceKeyPath: KeyPath<Value, T>, to object: O, _ objectKeyPath: ReferenceWritableKeyPath<O, R?>, transform: @escaping (T) -> R?)
```
