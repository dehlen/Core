import Foundation

public extension Date {
    /// Start of the day
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    /// String representation of a string
    ///
    /// - Parameters:
    ///   - format: A custom format for the used DateFormatter. Default is dd MMM y
    /// - Returns: The string representation of the date in the given format
    ///
    func string(format: String = "dd MMM y") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
