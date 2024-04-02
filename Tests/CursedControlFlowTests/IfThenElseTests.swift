//
//  IfThenElseTests.swift
//
//
//  Created by Óscar Morales Vivó on 3/29/24.
//

import CursedControlFlow
import Foundation
import XCTest

final class IfThenElseTests: XCTestCase {
    private func failTest() {
        XCTFail("This shouldn't happen")
    }
}

private let expectedValue = 7

extension IfThenElseTests {
    func testIfBlockThenBlockElseBlock() {
        let trueConditionExpectation = expectation(description: "Returning true")
        let thenExpectation = expectation(description: "Then")
        XCTAssertEqual(
            expectedValue,
            `if` {
                trueConditionExpectation.fulfill()
                return true
            }.then {
                thenExpectation.fulfill()
                return expectedValue
            }.else {
                self.failTest()
                return expectedValue - 1
            }
        )

        wait(for: [trueConditionExpectation, thenExpectation])

        let falseConditionExpectation = expectation(description: "Returning false")
        let elseExpectation = expectation(description: "Else")
        XCTAssertNotEqual(
            expectedValue,
            `if` {
                falseConditionExpectation.fulfill()
                return false
            }.then {
                self.failTest()
                return expectedValue
            }.else {
                elseExpectation.fulfill()
                return expectedValue - 1
            }
        )

        wait(for: [falseConditionExpectation, elseExpectation])
    }

    func testIfExpressionThenBlockElseBlock() {
        let thenExpectation = expectation(description: "Then")
        XCTAssertEqual(
            expectedValue,
            `if`(true).then {
                thenExpectation.fulfill()
                return expectedValue
            }.else {
                self.failTest()
                return expectedValue - 1
            }
        )

        wait(for: [thenExpectation])

        let elseExpectation = expectation(description: "Else")
        XCTAssertNotEqual(
            expectedValue,
            `if`(false).then {
                self.failTest()
                return expectedValue
            }.else {
                elseExpectation.fulfill()
                return expectedValue - 1
            }
        )

        wait(for: [elseExpectation])
    }

    func testIfExpressionThenExpressionElseExpression() {
        XCTAssertEqual(
            expectedValue,
            `if`(true).then(expectedValue).else(expectedValue - 1)
        )

        XCTAssertNotEqual(
            expectedValue,
            `if`(false).then(expectedValue).else(expectedValue - 1)
        )
    }
}
