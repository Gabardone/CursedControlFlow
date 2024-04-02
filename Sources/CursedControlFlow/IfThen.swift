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

public struct IfThen<T> {
    public let condition: IfCondition

    let then: () -> T

    init(condition: IfCondition, then: @escaping () -> T) {
        self.condition = condition
        self.then = then
    }
}

extension IfCondition {
    public func then(_ then: @escaping () -> Void) {
        _ = IfThen(condition: self, then: then).resolve()
    }

    public func then(_ then: @autoclosure @escaping () -> Void) {
        self.then(then)
    }

    public func then<T>(_ then: @escaping () -> T) -> IfThen<T> {
        .init(condition: self, then: then)
    }

    public func then<T>(_ then: @autoclosure @escaping () -> T) -> IfThen<T> {
        self.then(then)
    }
}

extension IfThen: IfThenElse {
    public func resolve() -> Resolution<T> {
        condition() ? .resolved(value: then()) : .unresolved
    }
}
