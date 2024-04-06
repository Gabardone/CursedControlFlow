//
//  ElseIfThenTests.swift
//
//
//  Created by Óscar Morales Vivó on 4/1/24.
//

import CursedControlFlow
import XCTest

final class ElseIfThenTests: XCTestCase {}

private func failTest() {
    XCTFail("This shouldn't happen")
}

private let expectedValue = 7

extension ElseIfThenTests {
    func testElseIfBlockThenBlockElseBlock() {
        let trueConditionExpectation = expectation(description: "Returning true")
        let elseIfThenExpectation = expectation(description: "Then")
        XCTAssertEqual(
            expectedValue,
            `if`(false).then(expectedValue + 1).elseIf {
                trueConditionExpectation.fulfill()
                return true
            }.then {
                elseIfThenExpectation.fulfill()
                return expectedValue
            }.else {
                failTest()
                return expectedValue - 1
            }
        )

        wait(for: [trueConditionExpectation, elseIfThenExpectation])

        let falseConditionExpectation = expectation(description: "Returning false")
        let elseIfThenElseExpectation = expectation(description: "Else")
        XCTAssertNotEqual(
            expectedValue,
            `if`(false).then(expectedValue + 1).elseIf {
                falseConditionExpectation.fulfill()
                return false
            }.then {
                failTest()
                return expectedValue
            }.else {
                elseIfThenElseExpectation.fulfill()
                return expectedValue - 1
            }
        )

        wait(for: [falseConditionExpectation, elseIfThenElseExpectation])
    }

    func testIfExpressionThenBlockElseBlock() {
        let elseIfThenExpectation = expectation(description: "Then")
        XCTAssertEqual(
            expectedValue,
            `if`(false).then(expectedValue + 1).elseIf(true).then {
                elseIfThenExpectation.fulfill()
                return expectedValue
            }.else {
                failTest()
                return expectedValue - 1
            }
        )

        wait(for: [elseIfThenExpectation])

        let elseIfThenElseExpectation = expectation(description: "Else")
        XCTAssertNotEqual(
            expectedValue,
            `if`(false).then(expectedValue + 1).elseIf(false).then {
                failTest()
                return expectedValue
            }.else {
                elseIfThenElseExpectation.fulfill()
                return expectedValue - 1
            }
        )

        wait(for: [elseIfThenElseExpectation])
    }

    func testIfExpressionThenExpressionElseExpression() {
        XCTAssertEqual(
            expectedValue,
            `if`(false).then(expectedValue + 1).elseIf(true).then(expectedValue).else(expectedValue - 1)
        )

        XCTAssertNotEqual(
            expectedValue,
            `if`(false).then(expectedValue + 1).elseIf(false).then(expectedValue).else(expectedValue - 1)
        )
    }
}
