import Foundation

public extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    func string(format: String = "dd MMM y") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
