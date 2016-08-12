import XCTest
@testable import SwiftTrace

class SwiftTraceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SwiftTrace().text, "Hello, World!")
    }


    static var allTests : [(String, (SwiftTraceTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
