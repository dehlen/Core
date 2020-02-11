import Foundation

public extension Bundle {
    /// The marketing version f.e 1.0.0
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// The build number f.e 42
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    /// The name of the application
    var appName: String? {
        return infoDictionary?[kCFBundleNameKey as String] as? String
    }
}
