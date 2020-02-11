import Foundation

public final class AssociatedObject<T: Any> {
    subscript(index: Any) -> T? {
        get {
            return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T?
        } set {
            objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
