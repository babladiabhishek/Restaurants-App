//
//  LoadingState.swift
//
//  Created by Abhishek B on 2024-05-13.
//

import Foundation
public enum LoadingState<T> {
    case idle
    case loading
    case loaded(_ with: T)
    case failed(_ error: Error)
}

extension LoadingState where T == Void {
    static var loaded: LoadingState {
        return .loaded(())
    }
}

/// Checks if the sates are equal. Ignore the value of T or the value of Error in any.

extension LoadingState: Equatable {
    public static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {

        case (.idle, .idle):
            return true

        case (.loading, .loading):
            return true

        case (.loaded, .loaded):
            return true

        case (.failed, .failed):
            return true

        default:
            return false
        }
    }
}

/// && operator for loading states.
/// Assumptions:
/// Any of 2 is loading => loading
/// Any of 2 is failed => failed
/// Any of 2 is idle => the other one's state is prioritized and returned
/// Both the same state => same state is the result

extension LoadingState where T == Void {
    static func && (lhs: LoadingState<T>, rhs: LoadingState<T>) -> LoadingState {

        if lhs == rhs { return lhs }

        if case LoadingState.failed = lhs { return lhs }
        if case LoadingState.failed = rhs { return rhs }

        if lhs == LoadingState.loading || rhs == LoadingState.loading { return LoadingState.loading }

        if lhs == LoadingState.idle { return rhs }

        return lhs
    }
}
