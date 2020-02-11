import Foundation

public extension String {
    /// Returns the localized string by using `self` as the key
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns an NSAttributedString with the parsed html as attributes
    func htmlAttributedString() -> NSAttributedString {
        do {
            let attrString = try NSAttributedString(data: data(using: .utf8)!,
                                                options: [.documentType : NSAttributedString.DocumentType.html],
                                                documentAttributes: nil)
            return attrString
        } catch {
            return NSAttributedString(string: self)
        }
    }

    /// Strips html tags from a string by using a simple regex of the form `<[^>]+>`
    func strippingHTML() -> String {
        return replacingOccurrences(of: "<[^>]+>",
                                    with: "",
                                    options: .regularExpression,
                                    range: nil)
    }
}
