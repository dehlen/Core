import Foundation

public extension Set {
    /// Returns nil if the element is not part of the Set else the element is returned
    func member(_ value: Element) -> Element? {
        if let index = self.firstIndex(of: value) {
            return self[index]
        } else {
            return nil
        }
    }
}
