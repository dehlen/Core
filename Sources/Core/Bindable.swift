/**
 Simple Generic type to bind a variable to another by hiding the Observer pattern as an implementation detail.
 
 Use like:
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
 */
public class Bindable<Value> {
    private var observations = [(Value) -> Bool]()
    private var lastValue: Value?
    
    public init(_ value: Value? = nil) {
        lastValue = value
    }
}

private extension Bindable {
    func addObservation<O: AnyObject>(
        for object: O,
        handler: @escaping (O, Value) -> Void
        ) {
        lastValue.map { handler(object, $0) }
        
        observations.append { [weak object] value in
            guard let object = object else {
                return false
            }
            
            handler(object, value)
            return true
        }
    }
}

public extension Bindable {
    func update(with value: Value) {
        lastValue = value
        observations = observations.filter { $0(value) }
    }
}

public extension Bindable {
    func bind<O: AnyObject, T>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, T>
        ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
    
    func bind<O: AnyObject, T>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        // This line is the only change compared to the previous
        // code sample, since the key path we're binding *to*
        // might contain an optional.
        _ objectKeyPath: ReferenceWritableKeyPath<O, T?>
        ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
    
    func bind<O: AnyObject, T, R>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, R?>,
        transform: @escaping (T) -> R?
        ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            let transformed = transform(value)
            object[keyPath: objectKeyPath] = transformed
        }
    }
}

