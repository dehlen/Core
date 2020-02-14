import Foundation

public protocol KeyPathUpdatable {}

public extension KeyPathUpdatable {
    /// Make a new copy with only one property changed
    func updating<LeafType>(_ keyPath: WritableKeyPath<Self, LeafType>, to value: LeafType) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
