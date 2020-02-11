import Foundation

/// Swifty alternative to do { try ... } catch { ... }
/// I.e. should { try throwingFunction) }.or(print($0))
func should(_ do: () throws -> Void) -> Error? {
    do {
        try `do`()
        return nil
    } catch let error {
        return error
    }
}


@discardableResult
public func with<T>(_ item: T, update: (inout T) throws -> Void) rethrows -> T {
    var this = item
    try update(&this)
    return this
}
