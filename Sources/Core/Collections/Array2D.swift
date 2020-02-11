import Foundation

public struct Array2D<T> {
    let columns: Int
    let rows: Int
    fileprivate var array: [T]
    
    init(rows: Int, columns: Int, initialValue: T) {
        self.rows = rows
        self.columns = columns
        array = .init(repeating: initialValue, count: rows * columns)
    }
    
    /// Returns the element at the specified row/colu,n if it is within bounds, otherwise nil.
    subscript(row: Int, column: Int) -> T {
        get {
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            return array[row*columns + column]
        }
        set {
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            array[row*columns + column] = newValue
        }
    }
}
