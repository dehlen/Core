import Foundation

public extension Int {
    func times (iterator: () -> Void) {
        for _ in 0..<self {
            iterator()
        }
    }
}
