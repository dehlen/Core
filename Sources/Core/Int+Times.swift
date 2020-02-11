import Foundation

public extension Int {
    /// Run the closure `self` times
    func times (iterator: () -> Void) {
        for _ in 0..<self {
            iterator()
        }
    }
}
