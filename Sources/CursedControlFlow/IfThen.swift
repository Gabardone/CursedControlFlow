//
//  IfThen.swift
//
//
//  Created by Óscar Morales Vivó on 3/31/24.
//

import Foundation

// MARK: - IfCondition

public struct IfCondition {
    fileprivate let condition: () -> Bool

    func callAsFunction() -> Bool {
        condition()
    }
}

public func `if`(_ condition: @escaping () -> Bool) -> IfCondition {
    IfCondition(condition: condition)
}

public func `if`(_ condition: @autoclosure @escaping () -> Bool) -> IfCondition {
    IfCondition(condition: condition)
}

// MARK: - IfThen

public struct IfThen<Value> {
    public let condition: IfCondition

    let then: () -> Value

    init(condition: IfCondition, then: @escaping () -> Value) {
        self.condition = condition
        self.then = then
    }
}

public extension IfCondition {
    func then(_ then: @escaping () -> Void) {
        _ = IfThen(condition: self, then: then).resolve()
    }

    func then(_ then: @autoclosure @escaping () -> Void) {
        self.then(then)
    }

    func then<Value>(_ then: @escaping () -> Value) -> IfThen<Value> {
        .init(condition: self, then: then)
    }

    func then<Value>(_ then: @autoclosure @escaping () -> Value) -> IfThen<Value> {
        self.then(then)
    }
}

extension IfThen: IfThenElse {
    public func resolve() -> Resolution<Value> {
        condition() ? .resolved(value: then()) : .unresolved
    }
}
