//
//  ElseIfThen.swift
//
//
//  Created by Óscar Morales Vivó on 4/1/24.
//

import Foundation

// MARK: - ElseIfCondition

public struct ElseIfCondition<T> {
    let parentResolver: () -> Resolution<T>

    let condition: () -> Bool

    public func callAsFunction() -> Bool {
        condition()
    }
}

public extension ElseIfCondition {
    func then(_ then: @escaping () -> T) -> ElseIfThen<T> {
        .init(condition: self, then: then)
    }

    func then(_ then: @autoclosure @escaping () -> T) -> ElseIfThen<T> {
        self.then(then)
    }
}

public extension ElseIfCondition where T == Void {
    func then(_ then: @escaping () -> Void) {
        _ = ElseIfThen(condition: self, then: then).resolve()
    }

    func then(_ then: @autoclosure @escaping () -> Void) {
        self.then(then)
    }
}

// MARK: - ElseIfThen

public struct ElseIfThen<T> {
    public let condition: ElseIfCondition<T>

    let then: () -> T

    fileprivate init(
        condition: ElseIfCondition<T>,
        then: @escaping () -> T
    ) {
        self.condition = condition
        self.then = then
    }
}

extension ElseIfThen: IfThenElse {
    public func resolve() -> Resolution<T> {
        switch condition.parentResolver() {
        case let .resolved(value: value):
            .resolved(value: value)

        case .unresolved:
            condition() ? .resolved(value: then()) : .unresolved
        }
    }
}
