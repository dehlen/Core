import Foundation

/// Wrapper to use Associated Objects in Swift
/// With associated objects you can attach any object to any other object without subclassing.
/// This way we can add instance variables to extension by leveraging the obj-c runtime
public final class AssociatedObject<T: Any> {
    subscript(index: Any) -> T? {
        get {
            return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T?
        } set {
            objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
