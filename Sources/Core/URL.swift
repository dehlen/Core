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

extension URL {
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
