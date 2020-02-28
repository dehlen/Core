public struct DefaultTrueStrategy: DefaultCodableStrategy {
    public static var defaultValue: Bool { return true }
}

/// Decodes Bools defaulting to `true` if applicable
///
/// `@DefaultTrue` decodes Bools and defaults the value to false if the Decoder is unable to decode the value.
public typealias DefaultTrue = DefaultCodable<DefaultTrueStrategy>
