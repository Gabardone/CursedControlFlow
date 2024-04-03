//
//  IfThenElse.swift
//
//
//  Created by Óscar Morales Vivó on 3/29/24.
//

import Foundation

public enum Resolution<T> {
    case resolved(value: T)
    case unresolved
}

// MARK: - IfThenElse

public protocol IfThenElse<T> {
    associatedtype T

    func resolve() -> Resolution<T>
}

public extension IfThenElse {
    func `else`(_ else: @escaping () -> T) -> T {
        switch resolve() {
        case let .resolved(value: value):
            value

        case .unresolved:
            `else`()
        }
    }

    func `else`(_ else: @autoclosure @escaping () -> T) -> T {
        self.else(`else`)
    }

    func elseIf(_ condition: @escaping () -> Bool) -> ElseIfCondition<T> {
        ElseIfCondition(
            parentResolver: resolve,
            condition: condition
        )
    }

    func elseIf(_ condition: @autoclosure @escaping () -> Bool) -> ElseIfCondition<T> {
        elseIf(condition)
    }
}

public extension IfThenElse where T == Void {
    func `else`(_ else: @escaping () -> Void) {
        if case .unresolved = resolve() {
            `else`()
        }
    }

    func `else`(_ else: @autoclosure @escaping () -> Void) {
        self.else(`else`)
    }
}
