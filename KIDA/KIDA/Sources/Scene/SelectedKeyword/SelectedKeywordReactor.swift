//
//  SelectedKeywordReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

final class SelectedKeywordReactor: Reactor {

    enum Action {
        case didTapConfirmButton
        case didTapRePickButton
    }

    struct State {
    }

    var initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didTapConfirmButton:
            return .just(.didTapConfirmButton)
        case .didTapRePickButton:
            // keywordSelect로 이동
            return .just(.didTapRePickButton)
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .didTapConfirmButton:
            return state
        case .didTapRePickButton:
            return state
        }
    }
}
