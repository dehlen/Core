import Foundation

/**
 Use this to annotate the properties with a default value if decoding fails.
 
 ~~~
 struct Product: Codable {
   var name: String
   
   @Default<Empty>
   var description: String
   
   @Default<True>
   var isAvailable: Bool
   
   @Default<FirstCase>
   var type: ProductType
 }
 ~~~
*/
@propertyWrapper
public struct Default<Provider: DefaultValueProvider>: Codable {
    public var wrappedValue: Provider.Value

    public init() {
        wrappedValue = Provider.default
    }

    public init(wrappedValue: Provider.Value) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            wrappedValue = Provider.default
        } else {
            wrappedValue = try container.decode(Provider.Value.self)
        }
    }
}

extension Default: Equatable where Provider.Value: Equatable {}

public extension KeyedDecodingContainer {
    func decode<P>(_: Default<P>.Type, forKey key: Key) throws -> Default<P> {
        if let value = try decodeIfPresent(Default<P>.self, forKey: key) {
            return value
        } else {
            return Default()
        }
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<P>(_ value: Default<P>, forKey key: Key) throws {
        guard value.wrappedValue != P.default else { return }
        try encode(value.wrappedValue, forKey: key)
    }
}

public protocol DefaultValueProvider {
    associatedtype Value: Equatable & Codable

    static var `default`: Value { get }
}

public enum False: DefaultValueProvider {
    public static let `default` = false
}

public enum True: DefaultValueProvider {
    public static let `default` = true
}

public enum Empty<A>: DefaultValueProvider where A: Codable, A: Equatable, A: RangeReplaceableCollection {
    public static var `default`: A { A() }
}

public enum FirstCase<A>: DefaultValueProvider where A: Codable, A: Equatable, A: CaseIterable {
    public static var `default`: A { A.allCases.first! }
}

public enum Zero: DefaultValueProvider {
    public static let `default` = 0
}

public enum One: DefaultValueProvider {
    public static let `default` = 1
}
