import Foundation
import CoreServices

public extension URL {
    var directoryURL: URL {
        return deletingLastPathComponent()
    }

    var directory: String {
        return directoryURL.path
    }

    var filename: String {
        get {
            return lastPathComponent
        }
        set {
            deleteLastPathComponent()
            appendPathComponent(newValue)
        }
    }

    var fileExtension: String {
        get {
            return pathExtension
        }
        set {
            deletePathExtension()
            appendPathExtension(newValue)
        }
    }

    var filenameWithoutExtension: String {
        get {
            return deletingPathExtension().lastPathComponent
        }
        set {
            let ext = pathExtension
            deleteLastPathComponent()
            appendPathComponent(newValue)
            appendPathExtension(ext)
        }
    }

    func changingFileExtension(to fileExtension: String) -> URL {
        var url = self
        url.fileExtension = fileExtension
        return url
    }

    func addingDictionaryAsQuery(_ dict: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        components.addDictionaryAsQuery(dict)
        return components.url ?? self
    }

    private func resourceValue<T>(forKey key: URLResourceKey) -> T? {
        guard let values = try? resourceValues(forKeys: [key]) else {
            return nil
        }

        return values.allValues[key] as? T
    }

    private func boolResourceValue(forKey key: URLResourceKey, defaultValue: Bool = false) -> Bool {
        guard let values = try? resourceValues(forKeys: [key]) else {
            return defaultValue
        }

        return values.allValues[key] as? Bool ?? defaultValue
    }

    /// File UTI
    var typeIdentifier: String? {
        return resourceValue(forKey: .typeIdentifierKey)
    }

    /// File size in bytes
    var fileSize: Int {
        return resourceValue(forKey: .fileSizeKey) ?? 0
    }

    var fileSizeFormatted: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var exists: Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    var isReadable: Bool {
        return boolResourceValue(forKey: .isReadableKey)
    }
}

#if os(macOS)
public extension URL {
    /**
    Check if the file conforms to the given type identifier

    ```
    URL(fileURLWithPath: "video.mp4").conformsTo(typeIdentifier: "public.movie")
    //=> true
    ```
    */
    func conformsTo(typeIdentifier parentTypeIdentifier: String) -> Bool {
        guard let typeIdentifier = typeIdentifier else {
            return false
        }

        return UTTypeConformsTo(typeIdentifier as CFString, parentTypeIdentifier as CFString)
    }

    /// - Important: This doesn't guarantee it's a video. A video container could contain only an audio track. Use the `AVAsset` properties to ensure it's something you can use.
    var isVideo: Bool {
        return conformsTo(typeIdentifier: kUTTypeMovie as String)
    }
}
#endif

private func escapeQuery(_ query: String) -> String {
    // From RFC 3986
    let generalDelimiters = ":#[]@"
    let subDelimiters = "!$&'()*+,;="

    var allowedCharacters = CharacterSet.urlQueryAllowed
    allowedCharacters.remove(charactersIn: generalDelimiters + subDelimiters)
    return query.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? query
}


public extension Dictionary where Key: ExpressibleByStringLiteral, Value: ExpressibleByStringLiteral {
    var asQueryItems: [URLQueryItem] {
        return map {
            URLQueryItem(
                name: escapeQuery($0 as! String),
                value: escapeQuery($1 as! String)
            )
        }
    }

    var asQueryString: String {
        var components = URLComponents()
        components.queryItems = asQueryItems
        return components.query!
    }
}


public extension URLComponents {
    mutating func addDictionaryAsQuery(_ dict: [String: String]) {
        percentEncodedQuery = dict.asQueryString
    }
}

public extension URL {
    
    /// Returns a URL constructed by appending the given query string parameter to self.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.appendingQueryItem("def", value: "456") // "https://example.com?abc=123&lmn=tuv&xyz=987&def=456"
    ///     url?.appendingQueryItem("xyz", value: "999") // "https://example.com?abc=123&lmn=tuv&xyz=999"
    ///
    /// - Parameters:
    ///   - name: The key of the query string parameter.
    ///   - value: The value to replace the query string parameter, nil will remove item.
    /// - Returns: The URL with the appended query string.
    func appendingQueryItem(_ name: String, value: Any?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return self
        }
        
        urlComponents.queryItems = urlComponents.queryItems?
            .filter { $0.name.caseInsensitiveCompare(name) != .orderedSame } ?? []
        
        // Skip if nil value
        if let value = value {
            urlComponents.queryItems?.append(URLQueryItem(name: name, value: "\(value)"))
        }
        
        return urlComponents.url ?? self
    }
    
    /// Returns a URL constructed by appending the given query string parameters to self.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.appendingQueryItems([
    ///         "def": "456",
    ///         "jkl": "777",
    ///         "abc": "333",
    ///         "lmn": nil
    ///     ]) // "https://example.com?xyz=987&def=456&abc=333&jkl=777"
    ///
    /// - Parameter contentsOf: A dictionary of query string parameters to modify.
    /// - Returns: The URL with the appended query string.
    func appendingQueryItems(_ contentsOf: [String: Any?]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString), !contentsOf.isEmpty else {
            return self
        }
        
        let keys = contentsOf.keys.map { $0.lowercased() }
        
        urlComponents.queryItems = urlComponents.queryItems?
            .filter { !keys.contains($0.name.lowercased()) } ?? []
        
        urlComponents.queryItems?.append(contentsOf: contentsOf.compactMap {
            guard let value = $0.value else { return nil } //Skip if nil
            return URLQueryItem(name: $0.key, value: "\(value)")
        })
        
        return urlComponents.url ?? self
    }
    
    /// Returns a URL constructed by removing the given query string parameter to self.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.removeQueryItem("xyz") // "https://example.com?abc=123&lmn=tuv"
    ///
    /// - Parameter name: The key of the query string parameter.
    /// - Returns: The URL with the mutated query string.
    func removeQueryItem(_ name: String) -> URL {
        appendingQueryItem(name, value: nil)
    }
}

public extension URL {
    
    /// Query a URL from a parameter name.
    ///
    ///     let url = URL(string: "https://example.com?abc=123&lmn=tuv&xyz=987")
    ///     url?.queryItem("aBc") // "123"
    ///     url?.queryItem("lmn") // "tuv"
    ///     url?.queryItem("yyy") // nil
    ///
    /// - Parameter name: The key of the query string parameter.
    /// - Returns: The value of the query string parameter.
    func queryItem(_ name: String) -> String? {
        // https://stackoverflow.com/q/41421686
        URLComponents(string: absoluteString)?
            .queryItems?
            .first { $0.name.caseInsensitiveCompare(name) == .orderedSame }?
            .value
    }
}
