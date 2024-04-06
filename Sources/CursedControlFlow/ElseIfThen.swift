//
//  ElseIfThen.swift
//
//
//  Created by Óscar Morales Vivó on 4/1/24.
//

import Foundation

// MARK: - ElseIfCondition

public struct ElseIfCondition<Value> {
    let parentResolver: () -> Resolution<Value>

    let condition: () -> Bool

    public func callAsFunction() -> Bool {
        condition()
    }
}

public extension ElseIfCondition {
    func then(_ then: @escaping () -> Value) -> ElseIfThen<Value> {
        .init(condition: self, then: then)
    }

    func then(_ then: @autoclosure @escaping () -> Value) -> ElseIfThen<Value> {
        self.then(then)
    }
}

public extension ElseIfCondition where Value == Void {
    func then(_ then: @escaping () -> Void) {
        _ = ElseIfThen(condition: self, then: then).resolve()
    }

    func then(_ then: @autoclosure @escaping () -> Void) {
        self.then(then)
    }
}

// MARK: - ElseIfThen

public struct ElseIfThen<Value> {
    public let condition: ElseIfCondition<Value>

    let then: () -> Value

    fileprivate init(
        condition: ElseIfCondition<Value>,
        then: @escaping () -> Value
    ) {
        self.condition = condition
        self.then = then
    }
}

extension ElseIfThen: IfThenElse {
    public func resolve() -> Resolution<Value> {
        switch condition.parentResolver() {
        case let .resolved(value: value):
            .resolved(value: value)

        case .unresolved:
            condition() ? .resolved(value: then()) : .unresolved
        }
    }
}
