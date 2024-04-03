//
//  IfThenElse.swift
//
//
//  Created by Óscar Morales Vivó on 3/29/24.
//

import Foundation

public enum Resolution<Value> {
    case resolved(value: Value)
    case unresolved
}

// MARK: - IfThenElse

public protocol IfThenElse<Value> {
    associatedtype Value

    func resolve() -> Resolution<Value>
}

public extension IfThenElse {
    func `else`(_ else: @escaping () -> Value) -> Value {
        switch resolve() {
        case let .resolved(value: value):
            value

        case .unresolved:
            `else`()
        }
    }

    func `else`(_ else: @autoclosure @escaping () -> Value) -> Value {
        self.else(`else`)
    }

    func elseIf(_ condition: @escaping () -> Bool) -> ElseIfCondition<Value> {
        ElseIfCondition(
            parentResolver: resolve,
            condition: condition
        )
    }

    func elseIf(_ condition: @autoclosure @escaping () -> Bool) -> ElseIfCondition<Value> {
        elseIf(condition)
    }
}

public extension IfThenElse where Value == Void {
    func `else`(_ else: @escaping () -> Void) {
        if case .unresolved = resolve() {
            `else`()
        }
    }

    func `else`(_ else: @autoclosure @escaping () -> Void) {
        self.else(`else`)
    }
}
