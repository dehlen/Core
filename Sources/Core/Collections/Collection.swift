import Foundation

public extension Collection {
    /// Returns Array<Element> sorted by a given key path
    func sorted<C: Comparable>(by keyPath: KeyPath<Element, C>) -> Array<Element> {
        return sorted { (left, right) -> Bool in
            let leftComparable = left[keyPath: keyPath]
            let rightComparable = right[keyPath: keyPath]
            return leftComparable < rightComparable
        }
    }
    
    /// Returns Array<Element> sorted by the given key paths
    func sorted<C1: Comparable, C2: Comparable>(by keyPath1: KeyPath<Element, C1?>, _ keyPath2: KeyPath<Element, C2>) -> Array<Element> {
        return sorted { (left, right) -> Bool in
            let l1 = left[keyPath: keyPath1]
            let r1 = right[keyPath: keyPath1]
            
            if l1 != nil && r1 == nil { return true }
            if l1 == nil && r1 != nil { return false }
            if let l = l1, let r = r1 {
                if l < r { return true }
                if l > r { return false }
            }
            
            // either l1 and r1 are both nil
            // or they are equal
            let l2 = left[keyPath: keyPath2]
            let r2 = right[keyPath: keyPath2]
            
            return l2 < r2
        }
    }
    
    /// Group a Collection into a dictionary by a given key path
    func keyed<H: Hashable>(by keyPath: KeyPath<Element, H>) -> Dictionary<H, Element> {
        var d = Dictionary<H, Element>()
        for item in self {
            let key = item[keyPath: keyPath]
            d[key] = item
        }
        return d
    }

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
