import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
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

    func strippingHTML() -> String {
        return replacingOccurrences(of: "<[^>]+>",
                                    with: "",
                                    options: .regularExpression,
                                    range: nil)
    }
}
