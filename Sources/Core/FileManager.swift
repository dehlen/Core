import Foundation

public extension FileManager {
    /// Copy a file and optionally overwrite the destination if it exists.
    func copyItem(at sourceURL: URL, to destinationURL: URL, overwrite: Bool = false) throws {
        if overwrite {
            try? FileManager.default.removeItem(at: destinationURL)
        }

        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
    }

    /// Remove file at url if exists
    func removeIfExists(at url: URL) throws {
        if url.exists {
            try removeItem(at: url)
        }
    }
}
