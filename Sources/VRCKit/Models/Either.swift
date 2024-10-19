//
//  Either.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/19.
//

public enum Either<L, R> {
    case left(L), right(R)
}

extension Either: Identifiable where L: Identifiable, R: Identifiable {
    public var id: AnyHashable {
        switch self {
        case .left(let value): value.id
        case .right(let value): value.id
        }
    }
}

extension Either: Equatable where L: Equatable, R: Equatable {
    public static func == (lhs: Either<L, R>, rhs: Either<L, R>) -> Bool {
        switch (lhs, rhs) {
        case (.left(let l1), .left(let l2)): l1 == l2
        case (.right(let r1), .right(let r2)): r1 == r2
        default: false
        }
    }
}

extension Either: Hashable where L: Hashable, R: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .left(let value):
            hasher.combine(0)
            hasher.combine(value)
        case .right(let value):
            hasher.combine(1)
            hasher.combine(value)
        }
    }
}

extension Either: Sendable where L: Sendable, R: Sendable {}
