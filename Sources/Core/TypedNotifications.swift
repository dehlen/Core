import Foundation

/// Protocol for a type sage notification
public protocol TypedNotification {
    associatedtype Sender
    static var name: String { get }
    var sender: Sender { get }
}

public extension TypedNotification {
    static var notificationName: Notification.Name {
        return Notification.Name(rawValue: name)
    }
}

/// Generic protocol for a type safe notification center
public protocol TypedNotificationCenter {
    func post<N : TypedNotification>(_ notification: N)
    func addObserver<N : TypedNotification>(_ forType: N.Type, sender: N.Sender?,
                                            queue: OperationQueue?, using block: @escaping (N) -> Void) -> NSObjectProtocol
}

extension NotificationCenter: TypedNotificationCenter {
    static var typedNotificationUserInfoKey = "_TypedNotification"

    /// Post a TypedNotification
    public func post<N>(_ notification: N) where N: TypedNotification {
        post(name: N.notificationName, object: notification.sender,
             userInfo: [
                NotificationCenter.typedNotificationUserInfoKey : notification
        ])
    }

    /// Add an observer for a TypedNotification
    public func addObserver<N>(_ forType: N.Type, sender: N.Sender?, queue: OperationQueue?, using block: @escaping (N) -> Void) -> NSObjectProtocol where N : TypedNotification {
        return addObserver(forName: N.notificationName, object: sender, queue: queue) { n in
            guard let typedNotification = n.userInfo?[NotificationCenter.typedNotificationUserInfoKey] as? N else {
                fatalError("Could not construct a typed notification: \(N.name) from notification: \(n)")
            }

            block(typedNotification)
        }
    }
}
