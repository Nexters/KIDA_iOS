//
//  PopupErrorReactor.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import Foundation

final class PopupErrorReactor: Reactor {

    enum Action {

    }

    struct State {

    }

    let initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Action> {

    }

    func reduce(state: State, mutation: Action) -> State {
        
    }
}
