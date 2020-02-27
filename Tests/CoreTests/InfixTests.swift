import XCTest
import Core

final class InfixTests: XCTestCase {
    func testConditionalAssign() {
        var someProperty = "abc"
        var someProperty2: String? = "def"
        var someValue: String?
        
        someProperty ?= someValue
        someProperty2 ?= someValue
        XCTAssertEqual(someProperty, "abc")
        XCTAssertEqual(someProperty2, "def")
        
        someValue = "xyz"
        someProperty ?= someValue
        someProperty2 ?= someValue
        XCTAssertEqual(someProperty, "xyz")
        XCTAssertEqual(someProperty2, "xyz")
        
        var test: Int? = 123
        var value: Int? = nil
        test ?= value
        XCTAssertEqual(test, 123)
        value = 456
        test ?= value
        XCTAssertEqual(test, 456)
    }
}
