import Foundation

public extension Dictionary where Value: Equatable {
    /// Returns all keys of the dictionary where value is matched
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
