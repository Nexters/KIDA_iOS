//
//  SelectedKeywordReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

final class SelectedKeywordReactor: Reactor {
    typealias Action = NoAction

    struct State {

    }

    var initialState: State

    init() {
        self.initialState = State()
    }
}
