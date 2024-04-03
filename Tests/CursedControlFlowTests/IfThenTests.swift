//
//  IfThenTests.swift
//
//
//  Created by Óscar Morales Vivó on 3/29/24.
//

import CursedControlFlow
import XCTest

final class IfThenTests: XCTestCase {
    func failTest() {
        XCTFail("This shouldn't happen")
    }
}

extension IfThenTests {
    func testIfBlockThenBlock() {
        let trueConditionExpectation = expectation(description: "Returning true")
        let thenExpectation = expectation(description: "Then")
        `if` {
            trueConditionExpectation.fulfill()
            return true
        }.then {
            thenExpectation.fulfill()
        }

        wait(for: [trueConditionExpectation, thenExpectation])

        let falseConditionExpectation = expectation(description: "Returning false")
        `if` {
            falseConditionExpectation.fulfill()
            return false
        }.then {
            self.failTest()
        }

        wait(for: [falseConditionExpectation])
    }

    func testIfExpressionThenBlock() {
        let thenExpectation = expectation(description: "Then")
        `if`(true).then {
            thenExpectation.fulfill()
        }

        wait(for: [thenExpectation])

        `if`(false).then {
            self.failTest()
        }
    }

    func testIfExpressionThenExpression() {
        let thenExpectation = expectation(description: "Then")
        `if`(true).then(thenExpectation.fulfill())
        wait(for: [thenExpectation])

        `if`(false).then(failTest())
    }
}
